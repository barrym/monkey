namespace :monkey do
  desc "Bootstraps app"
  task :bootstrap => [:environment, "db:migrate:reset"] do
    User.delete_all
    Folder.delete_all

    puts "Creating users"
    @barry = User.create!(:email => "barry.mitchelson@gmail.com", :name => "barrym", :password => "password")
    @barry.confirm_email!

    puts "Creating folders"
    @general = Folder.create!(:name => "General", :user => @barry)
    @gaming = Folder.create!(:name => "Gaming", :user => @barry)

    puts "Creating posts"
    Post.create(:user => @barry, :parent => @general, :subject => "This is a test post", :body => "This is the test body")

    puts "All Done"
  end
end
