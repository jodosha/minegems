class AddVersionsSummaryAndDescription < ActiveRecord::Migration
  def self.up
    add_column :versions, :summary,     :string
    add_column :versions, :description, :string
  end

  def self.down
    remove_column :versions, :summary
    remove_column :versions, :description
  end
end
