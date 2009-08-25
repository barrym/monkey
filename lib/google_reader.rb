require 'rubygems'
require 'httparty'
require 'ruby-debug'

barry_url = "http://www.google.com/reader/public/atom/user%2F18389778775339354804%2Fstate%2Fcom.google%2Fbroadcast"

class GoogleReader
  include HTTParty
  format :xml
end

def actual_url(url)
  case response = Net::HTTP.get_response(URI.parse(url))
  when Net::HTTPFound
    # puts response.code
    response['location']
  else
    url
  end
end



data = GoogleReader.get(barry_url)

data['feed']['entry'].each do |element|
  puts "Title : " << element['title']
  puts "ID : " << element['id']
  puts "Article URL : " << element['link']['href']
  puts "Actual Article URL : " << actual_url(element['link']['href'])
  # puts "Summary : " << (element['summary'] || 'n/a')
  puts "Source Name : " << element['source']['title']
  puts "Source URL : " << element['source']['link']['href']
  puts "Actual Source URL : " << actual_url(element['source']['link']['href'])
  puts "-----------------------"
end

