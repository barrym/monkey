# == Schema Information
# Schema version: 20090715185048
#
# Table name: folders
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  name        :string(255)
#  description :string(255)
#  global      :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#

class Folder < ActiveRecord::Base

  validates_presence_of :name, :user

  belongs_to :user

  # def to_param
  #   "thisisahash"
  # end

end
