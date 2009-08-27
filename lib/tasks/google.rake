namespace :google do
  namespace :reader do
    desc "Imports Google Reader shared items for all users"
    task :update => [:environment] do
      User.all.each do |user|
        if url = user.user_setting.google_reader_url
          puts "#{user.email} is sharing google items"

          feed = GoogleReader::Feed.new(url)
          feed.entries.each do |entry|
            puts entry.title
            SharedLink.share(
              :user => user,
              :url => entry.url,
              :original_url => entry.original_url,
              :title => entry.title,
              :source_name => "Google Reader"
            )
          end
        end
      end
    end
  end
end
