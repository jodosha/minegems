class Hostess < ::Sinatra::Base
  before do
    # TODO auth via http or token?
    env['warden'].authenticate!
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
    end
end