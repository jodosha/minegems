class CreateEarlyBirds < ActiveRecord::Migration
  def self.up
    create_table :early_birds do |t|
      t.string :email
      t.string :code
      t.datetime :activated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :early_birds
  end
end
