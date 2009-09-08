require 'ruby-debug'

ENV['RAILS_ENV'] = RAILS_ENV

namespace :friendfeed do
  desc "Imports FriendFeed shared items for all users"
  task :update => [:environment] do
    User.all.each do |user|
      unless (ff_username = user.user_setting.friendfeed_username).blank?
        puts "#{user.email} is sharing FriendFeed items"
        ff_password = user.user_setting.friendfeed_remote_key
        feed = FriendFeed::Feed.new(ff_username, ff_password)
        feed.entries.each do |entry|
          puts entry.url
          begin
          shared_link = SharedLink.share(
            :user => user,
            :url => entry.url,
            :original_url => entry.original_url,
            :title => entry.title,
            :source_name => "FriendFeed",
            :source_url => entry.source_url,
            :body => entry.body
          )
          rescue => e
            debugger
            puts "Error!"
          end
        end
      end
    end
  end
end
