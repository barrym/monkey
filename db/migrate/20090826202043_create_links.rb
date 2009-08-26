class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.integer :domain_id
      t.string :url
      t.string :title
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
