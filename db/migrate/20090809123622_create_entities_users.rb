class CreateEntitiesUsers < ActiveRecord::Migration
  def self.up
    create_table :entities_users do |t|
      t.references :entity, :polymorphic => true
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :entities_users
  end
end
