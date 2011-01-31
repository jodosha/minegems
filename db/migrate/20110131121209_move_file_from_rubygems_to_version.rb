class MoveFileFromRubygemsToVersion < ActiveRecord::Migration
  def self.up
    remove_column :rubygems, :file
    add_column    :versions, :file, :string
  end

  def self.down
    remove_column :versions, :file
    add_column    :rubygems, :file, :string
  end
end
