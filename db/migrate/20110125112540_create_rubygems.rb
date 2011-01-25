class CreateRubygems < ActiveRecord::Migration
  def self.up
    create_table :rubygems do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :rubygems
  end
end
