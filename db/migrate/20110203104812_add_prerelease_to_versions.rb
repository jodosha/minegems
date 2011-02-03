class AddPrereleaseToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :prerelease, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :versions, :prerelease
  end
end
