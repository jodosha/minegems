class Hostess < ::Sinatra::Base
  include Subdomains

  cattr_accessor :grid_fs
  self.grid_fs  = Mongo::GridFileSystem.new($mongo)

  %w[/specs.4.8.gz
     /latest_specs.4.8.gz
     /prerelease_specs.4.8.gz
  ].each do |index|
    get index do
      warden.authenticate!
      set_site!

      content_type('application/x-gzip')
      serve_via_grid_fs
    end
  end

  get "/gems/*.gem" do
    warden.authenticate!
    set_site!

    if name = Version.rubygem_name_for(full_name)
      # TODO download counter
      serve_via_s3
    else
      not_found("This is the gem you are looking for!.")
    end
  end

  get "/downloads/*.gem" do
    redirect "/gems/#{params[:splat]}.gem"
  end

  protected
    def serve_via_grid_fs
      begin
        self.class.grid_fs.open("indices/#{@site.tld}#{env['PATH_INFO']}", 'r').read
      rescue Mongo::GridFileNotFound => e
        not_found("This is the spec you are looking for!.")
      end
    end

    def serve_via_s3
      
    end

    def request
      @request ||= Rack::Request.new(env)
    end

    def current_user
      @current_user ||= warden.authenticate(:scope => :user)
    end

    def full_name
      @full_name ||= params[:splat].to_s.chomp('.gem')
    end

    def not_found(message)
      error 404, message
    end

    def warden
      env['warden']
    end

    def root_url
      'https://gemsmineapp.com'
    end
end