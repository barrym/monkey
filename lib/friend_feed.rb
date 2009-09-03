require 'httparty'

module FriendFeed

  class Feed
    include HTTParty
    BASE_URI = 'http://friendfeed-api.com/v2'
    format :json

    def initialize(username, key, num = 20)
      @username, @key = username, key
      @auth = {:username => @username, :password => @key}
      @num = num
    end

    def entries
      unless @entries
        data = get('/feed/' + @username, {:query => {:start => 0, :num => @num}})
        @entries = data['entries'].map { |entry| FriendFeed::Entry.new(entry) }.reverse
      end
      @entries
    end

    private

    def get(action, options = {})
      options.merge!({:basic_auth => @auth})
      self.class.get(self.class::BASE_URI + action, options)
    end

  end

  class Entry
    include SharedLinkHelpers

    attr_reader :data

    def initialize(data)
      @data = data
    end

    def title
      nil
    end

    def entry_id
      @data['id']
    end

    def original_url
      if @data['body'] =~ /href=\"([^\"]*)\"/
        url = $1
        url
      else
        nil
      end
    end

    def url
      @url ||= actual_url(original_url)
    end

    def source_name
      nil
    end

    def original_source_url
      @data['url']
    end

    def source_url
      @source_url ||= actual_url(original_source_url)
    end

    def inspect
      {:title => self.title}
    end

    def body
      @data['body']
    end

  end

end

# f = FriendFeed.new(username, key)
#
# f.feed(5)['entries'].each do |entry|
#   puts "FriendFeed ID : " << entry['id']
#   puts "FriendFeed URL : " << entry['url']
#   entry['body'] =~ /href=\"([^\"]*)\"/
#   puts "Probable Article URL : " << $1
#   puts "Actual Probable Article URL : " << actual_url($1)
#   puts "Body : " << entry['body']
#   puts "From Object : " << entry['from'].inspect
#   puts "Comments Object : " << entry['comments'].inspect
#   puts "----------------"
# end
