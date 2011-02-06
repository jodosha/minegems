class AddLatestToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :latest, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :versions, :latest
  end
end
