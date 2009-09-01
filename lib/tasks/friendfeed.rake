namespace :friendfeed do
  desc "Imports FriendFeed shared items for all users"
  task :update => [:environment] do
    User.all.each do |user|
      if ff_username = user.user_setting.friendfeed_username
        puts "#{user.email} is sharing FriendFeed items"
        ff_password = user.user_setting.friendfeed_remote_key
        feed = FriendFeed::Feed.new(ff_username, ff_password)
        feed.entries.each do |entry|
          puts entry.body
          puts entry.url
          puts "------------------------------------"
        end
        # feed.entries.each do |entry|
        #   puts entry.title
        #   SharedLink.share(
        #     :user => user,
        #     :url => entry.url,
        #     :original_url => entry.original_url,
        #     :title => entry.title,
        #     :source_name => "Google Reader"
        #   )
      end
    end
  end
end
