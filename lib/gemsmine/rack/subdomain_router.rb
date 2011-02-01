require 'subdomain'

module Gemsmine
  module Rack
    class SubdomainRouter
      @@reserved_names = %w(about account accounts admin api app apps assets0 assets1 assets2 assets3 atom auth authentication blog cache connect downloads email faq feeds gems help home invitations jobs lists logs messages mine news oauth openid privacy rss search secure security sessions shop ssl staging support url widget widgets wiki www xfn xmpp).freeze
      RESERVED_NAMES = @@reserved_names.inject({}) { |memo,name| memo[name] = true; memo }.freeze

      cattr_accessor :lookup_prefix
      self.lookup_prefix = "subdomains"

      cattr_accessor :access_prefix
      self.access_prefix = "site"

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

      def self.access_granted?(site, user)
        $redis.sismember("#{access_prefix}.#{site['tld']}", user.id)
      end

      def self.create_access(site, user, redis = $redis)
        redis.sadd("#{access_prefix}.#{site.tld}", user.id)
      end

      def self.remove_access(site, user, redis = $redis)
        redis.srem("#{access_prefix}.#{site.tld}", user.id)
      end

      def self.ensure_consistent_access!
        unless $redis.keys("#{access_prefix}.*").size == Subdomain.count
          $redis.multi do |redis|
            Subdomain.all(:select => [:id, :tld], :include => :users).each do |subdomain|
              redis.del("#{access_prefix}.#{subdomain.tld}")

              subdomain.users.each do |user|
                create_access(subdomain, user, redis)
              end
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
puts request.subdomain
puts self.class.lookup(request.subdomain).inspect
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