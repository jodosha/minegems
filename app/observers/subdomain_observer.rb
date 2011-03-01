class SubdomainObserver < ActiveRecord::Observer
  def after_save(subdomain)
    Minegems::Rack::SubdomainRouter.update_lookup(subdomain)
  end
end