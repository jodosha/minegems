class CreateSubdomains < ActiveRecord::Migration
  def self.up
    create_table :subdomains do |t|
      t.string :name

      t.timestamps
    end

    add_index :subdomains, :name
  end

  def self.down
    delete_index :subdomains, :name
    drop_table   :subdomains
  end
end
