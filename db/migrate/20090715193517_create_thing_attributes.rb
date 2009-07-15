class CreateThingAttributes < ActiveRecord::Migration
  def self.up
    create_table :thing_attributes do |t|
      t.integer :thing_id
      t.string :key
      t.string :value
      t.timestamps
    end

    add_index :thing_attributes, [:thing_id, :key], :unique => true
  end

  def self.down
    drop_table :thing_attributes
  end
end
