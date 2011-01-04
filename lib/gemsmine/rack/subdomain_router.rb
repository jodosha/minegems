require 'subdomain'

module Gemsmine
  module Rack
    class SubdomainRouter
      @@reserved_names = %w(about account accounts admin api app apps assets0 assets1 assets2 assets3 atom auth authentication blog cache connect downloads email faq feeds gems help home invitations jobs lists logs messages mine news oauth openid privacy rss search secure security sessions shop ssl staging support url widget widgets wiki www xfn xmpp).freeze
      RESERVED_NAMES = @@reserved_names.inject({}) { |memo,name| memo[name] = true; memo }.freeze

      def self.matches?(request)
        request.env['GEMSMINE_SITE'].present?
      end

      def initialize(app)
        @app = app
      end

      def call(env)
        request = ActionDispatch::Request.new(env)
        if self.class.valid?(request)
          env['GEMSMINE_SITE'] = ::Subdomain.lookup(request.subdomain)
        end

        @app.call(env)
      end

      protected
        def self.valid?(request)
          request.subdomain.present? && !RESERVED_NAMES[request.subdomain]
        end
    end
  end
end