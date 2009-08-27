namespace :monkey do
  desc "Bootstraps app"
  task :bootstrap => [:environment, "db:migrate:reset"] do

    puts "Creating users"
    @barry = User.create!(:email => "barry.mitchelson@gmail.com", :name => "barrym", :password => "password")
    @barry.confirm_email!

    @tony = User.create!(:email => "lasersarebrilliant@gmail.com", :name => "Tony Coles", :password => "password")
    @tony.confirm_email!

    @mark = User.create!(:email => "mark.sorrell@gmail.com", :name => "Mark Sorrell", :password => "password")
    @mark.confirm_email!

    @stiff = User.create!(:email => "hyper.steve@gmail.com", :name => "Stiff", :password => "password")
    @stiff.confirm_email!

    @duncan = User.create!(:email => "duncan.metcalfe@gmail.com", :name => "Duncan", :password => "password")
    @duncan.confirm_email!

    puts "Creating categories"
    @general = Category.create!(:name => "Off Topic")
    @iphone = Category.create!(:name => "iPhone")
    @tweets = Category.create!(:name => "Tweets", :system => true)
    @links = Category.create!(:name => "Links", :system => true)
    @gaming = Category.create!(:name => "Gaming")

    puts "Creating links"
    @old_findus = Link.create!(:url => "http://talk.theshining.org", :title => "Old Findus", :domain_id => 1)

    puts "Creating shared links"
    @b_link = SharedLink.create!(:user => @barry, :link => @old_findus, :source_name => "FriendFeed", :source_url => "http://www.friendfeed.com", :original_url => "http://talk.theshining.org", :category_ids => [@links.id])
    @m_link = SharedLink.create!(:user => @mark, :link => @old_findus, :source_name => "Google Reader", :source_url => "http://www.google.com/reader", :original_url => "http://talk.theshining.org", :category_ids => [@links.id])

    puts "Creating tweets"
    @b_tweet = Tweet.create!(:user => @barry, :body => "At Starbucks.", :tweeted_at => Time.now, :category_ids => [@tweets.id])

    puts "Creating posts"
    @m_post = Post.create!(:user => @mark, :subject => "I <3 my iPhone", :body => "I hug it every morning.\n[img]http://pictureslol.theshining.org/pictures/4092/iPhoneGen1_preview.png[/img]", :category_ids => [@iphone.id])

    @m_post = Post.create!(:user => @mark, :subject => "Wassup", :body => "What's my name?", :category_ids => [@general.id])
    @m_post.comments.create(:user => @barry, :body => "Mark!")

    sleep 1 # force the timestamps

    @b_post = Post.create!(:user => @barry, :subject => "This is a test post", :body => "Some place in Dean Street apparently. The Couch is safe, sadly. Apparently a Chinese restaurant, but that's only what twitter is saying.\n\ntalking of bears, have you wasted 99 cents on Enviro-bear yet?", :category_ids => [@general.id])
    @b_post.comments.create(:user => @tony, :body => "[quote=#{@barry.display_name}]#{@b_post.body}[/quote]\nSweet post, bro")
    @b_post.comments.create(:user => @mark, :body => "Yeah, sweet post, bro")

    sleep 1

    @s_post = Post.create!(:user => @stiff, :subject => "Check out my new trainers, bro", :body => "[img]http://pictureslol.theshining.org/pictures/4070/Picture_20hi_20tec_20squash_preview.jpg[/img]", :category_ids => [@general.id])

    puts "All Done"
  end
end
