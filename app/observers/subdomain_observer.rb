class SubdomainObserver < ActiveRecord::Observer
  def after_save(subdomain)
    Gemsmine::Rack::SubdomainRouter.update_lookup(subdomain)
  end
end