# == Schema Information
# Schema version: 20090715185048
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
#  name               :string(255)
#

class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :name

  has_many :folders
  has_many :things

  def display_name
    self.name || self.email
  end

end
