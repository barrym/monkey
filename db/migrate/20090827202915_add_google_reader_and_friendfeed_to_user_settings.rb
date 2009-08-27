class AddGoogleReaderAndFriendfeedToUserSettings < ActiveRecord::Migration
  def self.up
    add_column :user_settings, :google_reader_url, :text
    add_column :user_settings, :friendfeed_username, :string
    add_column :user_settings, :friendfeed_remote_key, :string
  end

  def self.down
  end
end
