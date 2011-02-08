class Hostess < ::Sinatra::Base
  unless Rails.env.test?
    include Subdomains

    before do
      warden.authenticate!
      set_site!
    end
  end

  %w[/specs.4.8.gz
     /latest_specs.4.8.gz
     /prerelease_specs.4.8.gz
  ].each do |index|
    get index do
      content_type('application/x-gzip')
      serve_via_grid_fs
    end
  end

  protected
    def serve_via_grid_fs
      begin
        grid_fs.open("indices/#{@site.tld}#{env['PATH_INFO']}", 'r').read
      rescue Mongo::GridFileNotFound => e
        raise Sinatra::NotFound
      end
    end

    def grid_fs
      @grid_fs ||= Mongo::GridFileSystem.new($mongo)
    end

    def request
      @request ||= Rack::Request.new(env)
    end

    def current_user
      @current_user ||= warden.authenticate(:scope => :user)
    end

    def warden
      env['warden']
    end

    def root_url
      'https://gemsmineapp.com'
    end
end