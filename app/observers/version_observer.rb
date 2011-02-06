class VersionObserver < ActiveRecord::Observer
  def after_save(version)
    Resque.enqueue(IndexWorker, version.rubygem.subdomain.id)
  end
  alias_method :after_destroy, :after_save
end