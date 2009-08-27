require 'httparty'
# barry_url = "http://www.google.com/reader/public/atom/user%2F18389778775339354804%2Fstate%2Fcom.google%2Fbroadcast"

module GoogleReader

  class Feed
    include HTTParty
    format :xml

    def initialize(url)
      @url = url
    end

    def entries
      unless @entries
        data = self.class.get(@url)
        @entries = data['feed']['entry'].map { |entry| GoogleReader::Entry.new(entry) }
      end
      @entries
    end

    def inspect
      {:url => @url}
    end

  end

  class Entry
    include SharedLinkHelpers

    def initialize(data)
      @data = data
    end

    def title
      @data['title']
    end

    def entry_id
      @data['id']
    end

    def original_url
      @data['link']['href']
    end

    def url
      @url ||= actual_url(original_url)
    end

    def source_name
      @data['source']['title']
    end

    def original_source_url
      @data['source']['link']['href']
    end

    def source_url
      @source_url ||= actual_url(original_source_url)
    end

    def inspect
      {:title => self.title}
    end

  end

end
#
#
# feed = GoogleReader::Feed.new(barry_url)
#
# feed.entries.each do |entry|
#   puts "Title : " << entry.title
#   puts "ID : " << entry.entry_id
#   puts "Article URL : " << entry.original_url
#   puts "Actual Article URL : " << entry.url
#   # puts "Summary : " << (element['summary'] || 'n/a')
#   puts "Source Name : " << entry.source_name
#   puts "Source URL : " << entry.original_source_url
#   puts "Actual Source URL : " << entry.source_url
#   puts "-----------------------"
# end
