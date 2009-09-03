class AddItemsPerPageToUserSettings < ActiveRecord::Migration
  def self.up
    add_column :user_settings, :items_per_page, :integer, :default => 20
  end

  def self.down
    remove_column :user_settings, :items_per_page
  end
end
