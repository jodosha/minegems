class SubdomainRouter
  @@reserved_names = %w(about account accounts admin api app apps assets0 assets1 assets2 assets3 atom auth authentication blog cache connect downloads email faq feeds gems help home invitations jobs lists logs messages mine news oauth openid privacy rss search secure security sessions shop ssl support url widget widgets wiki www xfn xmpp).freeze
  RESERVED_NAMES = @@reserved_names.inject({}) { |memo,current| memo[current] = true; memo }.freeze

  def self.matches?(request)
    request.subdomain.present? && !RESERVED_NAMES[request.subdomain]
  end
end