class Hostess < ::Sinatra::Base
  include Subdomains

  cattr_accessor :grid_fs
  self.grid_fs = Mongo::GridFileSystem.new($mongo)

  %w[/specs.4.8.gz
     /latest_specs.4.8.gz
     /prerelease_specs.4.8.gz
  ].each do |index|
    get index do
      set_deploy_user!
      warden.authenticate!
      set_site!

      content_type('application/x-gzip')
      serve_via_grid_fs('indices')
    end
  end

  get "/quick/Marshal.4.8/*.gemspec.rz" do
    set_deploy_user!
    warden.authenticate!
    set_site!

    if Version.rubygem_name_for(full_name)
      content_type('application/x-deflate')
      serve_via_grid_fs('quick', "/Marshal.4.8/#{full_name}.gemspec.rz")
    else
      not_found("This is not the gem you are looking for!.")
    end
  end

  get "/gems/*.gem" do
    set_deploy_user!
    warden.authenticate!
    set_site!

    if version = @site.versions.by_full_name(full_name).first
      # TODO download counter
      serve_via_s3(version)
    else
      not_found("This is not the gem you are looking for!.")
    end
  end

  get "/downloads/*.gem" do
    redirect "/gems/#{params[:splat]}.gem"
  end

  protected
    def serve_via_grid_fs(prefix, path = env['PATH_INFO'])
      begin
        self.class.grid_fs.open("/#{prefix}/#{@site.tld}#{path}", 'r').read
      rescue Mongo::GridFileNotFound => e
        # TODO log this critical situation
        not_found("This is not the spec you are looking for!.")
      end
    end

    def serve_via_s3(version)
      begin
        version.file.read
      rescue Excon::Errors::NotFound => e
        # TODO log this critical situation
        not_found("This is not the gem you are looking for!.")
      end
    end

    def request
      @request ||= Rack::Request.new(env)
    end

    def current_user
      @current_user ||= warden.authenticate(:scope => :user)
    end

    def full_name
      @full_name ||= params[:splat].first.chomp('.gem')
    end

    def not_found(message)
      error 404, message
    end

    def warden
      env['warden']
    end

    def root_url
      'http://minege.ms'
    end
end