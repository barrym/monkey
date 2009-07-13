# == Schema Information
# Schema version: 20090712192739
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  email              :string(255)
#  encrypted_password :string(128)
#  salt               :string(128)
#  token              :string(128)
#  token_expires_at   :datetime
#  email_confirmed    :boolean(1)      not null
#  created_at         :datetime
#  updated_at         :datetime
#

class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :name

  def display_name
    self.name || self.email
  end

end
