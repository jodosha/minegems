class AddSpecToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :spec, :string
  end

  def self.down
    remove_column :versions, :spec
  end
end
