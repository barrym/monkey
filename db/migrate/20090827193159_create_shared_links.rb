class CreateSharedLinks < ActiveRecord::Migration
  def self.up
    create_table :shared_links do |t|
      t.integer :link_id
      t.integer :user_id
      t.string :original_url
      t.string :source_url
      t.string :source_name
      t.string :body
      t.timestamps
    end
  end

  def self.down
    drop_table :shared_links
  end
end
