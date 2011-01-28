class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.integer :rubygem_id
      t.string :number

      t.timestamps
    end
  end

  def self.down
    drop_table :versions
  end
end
