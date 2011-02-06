class AddSpecsIndexToSubdomains < ActiveRecord::Migration
  def self.up
    add_column :subdomains, :specs_index, :string
  end

  def self.down
    remove_column :subdomains, :specs_index
  end
end
