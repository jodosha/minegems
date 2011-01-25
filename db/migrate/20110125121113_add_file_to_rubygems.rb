class AddFileToRubygems < ActiveRecord::Migration
  def self.up
    add_column :rubygems, :file, :string
  end

  def self.down
    remove_column :rubygems, :file
  end
end
