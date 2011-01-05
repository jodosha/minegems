class MembershipObserver < ActiveRecord::Observer
  def after_create(membership)
    Gemsmine::Rack::SubdomainRouter.create_access(membership.subdomain, membership.user)
  end

  def after_destroy(membership)
    Gemsmine::Rack::SubdomainRouter.remove_access(membership.subdomain, membership.user)
  end
end