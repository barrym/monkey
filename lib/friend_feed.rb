require 'rubygems'
require 'httparty'
require 'ruby-debug'

username = "barrym"
key = "lols"

def actual_url(url)
  case response = Net::HTTP.get_response(URI.parse(url))
  when Net::HTTPFound
    # puts response.code
    response['location']
  else
    url
  end
end

class FriendFeed
  include HTTParty
  BASE_URI = 'http://friendfeed-api.com/v2'
  format :json

  def initialize(username, key)
    @username, @key = username, key
    @auth = {:username => @username, :password => @key}
  end

  def feed(num = 10)
    get('/feed/' + @username, {:query => {:start => 0, :num => num}})
  end

  private

  def get(action, options = {})
    options.merge!({:basic_auth => @auth})
    self.class.get(self.class::BASE_URI + action, options)
  end

end

f = FriendFeed.new(username, key)

f.feed(5)['entries'].each do |entry|
  puts "FriendFeed ID : " << entry['id']
  puts "FriendFeed URL : " << entry['url']
  entry['body'] =~ /href=\"([^\"]*)\"/
  puts "Probable Article URL : " << $1
  puts "Actual Probable Article URL : " << actual_url($1)
  puts "Body : " << entry['body']
  puts "From Object : " << entry['from'].inspect
  puts "Comments Object : " << entry['comments'].inspect
  puts "----------------"
end
