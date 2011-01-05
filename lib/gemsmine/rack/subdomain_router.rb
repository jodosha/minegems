require 'subdomain'

module Gemsmine
  module Rack
    class SubdomainRouter
      @@reserved_names = %w(about account accounts admin api app apps assets0 assets1 assets2 assets3 atom auth authentication blog cache connect downloads email faq feeds gems help home invitations jobs lists logs messages mine news oauth openid privacy rss search secure security sessions shop ssl staging support url widget widgets wiki www xfn xmpp).freeze
      RESERVED_NAMES = @@reserved_names.inject({}) { |memo,name| memo[name] = true; memo }.freeze

      cattr_accessor :lookup_prefix
      self.lookup_prefix = "subdomains"

      def self.matches?(request)
        request.env['GEMSMINE_SITE'].present?
      end

      def self.lookup(subdomain)
        $redis.mapped_hmget("#{lookup_prefix}.#{subdomain}", "tld", "name")
      end

      def self.update_lookup(subdomain, redis = $redis)
        redis.mapped_hmset("#{lookup_prefix}.#{subdomain.tld}", :tld => subdomain.tld, :name => subdomain.name)
      end

      def self.ensure_consistent_lookup!
        unless $redis.keys("#{lookup_prefix}.*").size == Subdomain.count
          $redis.multi do |redis|
            Subdomain.all(:select => [:tld, :name]).each do |subdomain|
              update_lookup(subdomain, redis)
            end
          end
        end
      end

      def initialize(app)
        @app = app
      end

      def call(env)
        request = ActionDispatch::Request.new(env)
        if self.class.valid?(request)
          env['GEMSMINE_SITE'] = self.class.lookup(request.subdomain)
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