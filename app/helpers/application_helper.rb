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

end
