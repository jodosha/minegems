class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.references :subdomain
      t.references :user
      t.string :role

      t.timestamps
    end

    add_index :memberships, [ :subdomain_id, :user_id ]
    add_index :memberships, [ :subdomain_id, :user_id, :role ]
  end

  def self.down
    remove_index :memberships, [ :subdomain_id, :user_id, :role ]
    remove_index :memberships, [ :subdomain_id, :user_id ]

    drop_table   :memberships
  end
end
