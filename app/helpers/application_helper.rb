# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def gravatar_url(email, options = {})
    options[:rating] ||= nil
    options[:size] ||= nil
    options[:default] ||= nil

    grav_url = 'http://www.gravatar.com/avatar.php?'
    grav_url << "gravatar_id=#{Digest::MD5.new.update(email)}"
    grav_url << "&rating=#{options[:rating]}" if options[:rating]
    grav_url << "&size=#{options[:size]}" if options[:size]
    grav_url << "&default=#{options[:default]}" if options[:default]
    grav_url
  end

  def post_preview(text)
    # logger.info(text)
    # logger.info("size : #{text.size}")
    # if text.size > 300
      # truncate(text, :length => 200, :omission => "...")
    # else
      text.bbcode_to_html
    # end
  end

  def pretty_time(time)
    meridian = time.hour >= 12 ? "pm" : "am"
    time.strftime("%a %b %d %l:%M#{meridian}")
  end

end
