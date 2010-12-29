class CreateSubdomains < ActiveRecord::Migration
  def self.up
    create_table :subdomains do |t|
      t.string :tld
      t.string :name

      t.timestamps
    end

    add_index :subdomains, :tld, :unique => true
  end

  def self.down
    delete_index :subdomains, :tld
    drop_table   :subdomains
  end
end
