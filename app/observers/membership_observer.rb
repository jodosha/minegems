class MembershipObserver < ActiveRecord::Observer
  def after_create(membership)
    Minegems::Rack::SubdomainRouter.create_access(membership.subdomain, membership.user)
  end

  def after_destroy(membership)
    Minegems::Rack::SubdomainRouter.remove_access(membership.subdomain, membership.user)
  end
end