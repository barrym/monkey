class CreateEntityAttributes < ActiveRecord::Migration
  def self.up
    create_table :entity_attributes do |t|
      t.integer :entity_id
      t.string :key
      t.string :value
      t.timestamps
    end

    add_index :entity_attributes, [:entity_id, :key], :unique => true
  end

  def self.down
    drop_table :entity_attributes
  end
end
