class AddFullNameToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :full_name, :string
  end

  def self.down
    remove_column :versions, :full_name
  end
end
