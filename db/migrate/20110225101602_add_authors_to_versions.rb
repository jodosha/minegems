class AddAuthorsToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :authors, :text
  end

  def self.down
    remove_column :versions, :authors
  end
end
