namespace :monkey do
  desc "Bootstraps app"
  task :bootstrap => [:environment, "db:migrate:reset"] do
    User.delete_all
    Folder.delete_all

    puts "Creating users"
    @barry = User.create!(:email => "barry.mitchelson@gmail.com", :name => "barrym", :password => "password")
    @barry.confirm_email!

    @tony = User.create!(:email => "lasersarebrilliant@gmail.com", :name => "Tony Coles", :password => "password")
    @tony.confirm_email!

    @mark = User.create!(:email => "mark.sorrell@gmail.com", :name => "Mark Sorrell", :password => "password")
    @mark.confirm_email!

    puts "Creating folders"
    @general = Folder.create!(:name => "General", :user => @barry)
    @gaming = Folder.create!(:name => "Gaming", :user => @barry)

    puts "Creating tweets"
    @b_tweet = @general.tweets.create(:user => @barry, :body => "At Starbucks.", :tweeted_at => Time.now)

    puts "Creating posts"
    @m_post = @general.posts.create(:user => @mark, :subject => "Wassup", :body => "What's my name?\n\n\nWhat's my name?\n\n")
    @m_post.comments.create(:user => @barry, :body => "Mark!")

    sleep 1 # force the timestamps

    @b_post = @general.posts.create(:user => @barry, :subject => "This is a test post", :body => "Some place in Dean Street apparently. The Couch is safe, sadly. Apparently a Chinese restaurant, but that's only what twitter is saying.\n\ntalking of bears, have you wasted 99 cents on Enviro-bear yet?")
    @b_post.comments.create(:user => @tony, :body => "[quote=#{@barry.display_name}]#{@b_post.body}[/quote]\nSweet post, bro")
    @b_post.comments.create(:user => @mark, :body => "Yeah, sweet post, bro")

    puts "All Done"
  end
end
