Gemsmine::Rack::SubdomainRouter.class_eval do
  def self.matches?(request)
    valid?(request)
  end
end
