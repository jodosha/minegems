class AddSubdomainIdToRubygems < ActiveRecord::Migration
  def self.up
    add_column :rubygems, :subdomain_id, :integer
  end

  def self.down
    remove_column :rubygems, :subdomain_id
  end
end
