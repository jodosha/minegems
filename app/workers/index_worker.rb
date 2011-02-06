class IndexWorker
  @queue = :index

  def self.perform(subdomain_id)
    subdomain = Subdomain.find(subdomain_id)
    subdomain.update_index!
  end
end