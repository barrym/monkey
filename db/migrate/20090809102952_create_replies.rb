class CreateReplies < ActiveRecord::Migration
  def self.up
    create_table :replies do |t|
      t.integer :user_id
      t.integer :post_id
      t.string  :name
      t.string  :body
      t.timestamps
    end
  end

  def self.down
    drop_table :replies
  end
end
