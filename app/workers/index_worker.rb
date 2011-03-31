require 'resque/plugins/resque_heroku_autoscaler'

class IndexWorker
  if Rails.env.production? or Rails.env.staging?
    extend ::Resque::Plugins::HerokuAutoscaler
  end

  @queue = :index

  def self.perform(subdomain_id)
    subdomain = Subdomain.find(subdomain_id)
    subdomain.update_index!
  end
end