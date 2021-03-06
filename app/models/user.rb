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

  has_one :user_setting
  has_many :folders
  has_many_polymorphs :entities, :from => [:posts, :comments, :tweets, :shared_links]

  after_create :add_user_setting

  def display_name
    self.name.blank? ? self.email : self.name
  end

  private

  def add_user_setting
    self.user_setting = UserSetting.new(:display_mode => 'classic')
  end

end
