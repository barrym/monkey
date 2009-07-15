class CreateThings < ActiveRecord::Migration
  def self.up
    create_table :things do |t|
      t.integer :user_id
      t.integer :folder_id
      t.integer :parent_id
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :things
  end
end
