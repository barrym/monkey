module SharedLinkHelpers

  def actual_url(url)
    case response = Net::HTTP.get_response(URI.parse(url))
    when Net::HTTPFound
      # puts response.code
      response['location']
    else
      url
    end
  end

end
