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

    puts "Creating posts"
    @b_post = @general.posts.create(:user => @barry, :subject => "This is a test post", :body => "This is the test body")
    @b_post.comments.create(:user => @mark, :body => "Sweet post, bro")
    @b_post.comments.create(:user => @tony, :body => "Yeah, sweet post, bro")

    sleep 1

    @m_post = @general.posts.create(:user => @mark, :subject => "Wassup", :body => "What's my name?\n\n\nWhat's my name?\n\n")
    @m_post.comments.create(:user => @barry, :body => "Mark!")

    puts "All Done"
  end
end
