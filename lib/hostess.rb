class Hostess < ::Sinatra::Base
  unless Rails.env.test?
    before do
      env['warden'].authenticate!
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
    end
end