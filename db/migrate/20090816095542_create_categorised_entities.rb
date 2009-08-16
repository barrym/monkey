class CreateCategorisedEntities < ActiveRecord::Migration
  def self.up
    create_table :categorised_entities do |t|
      t.integer :category_id
      t.integer :entity_id
      t.string :entity_type

      t.timestamps
    end
  end

  def self.down
    drop_table :categorised_entities
  end
end
