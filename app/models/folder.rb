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

  belongs_to :user
  has_many_polymorphs :children, :from => [:posts,:tweets]

  validates_presence_of :user

  # def to_param
  #   "thisisahash"
  # end

  def recent_children(limit = 20)
    self.children.find(:all, :order => "IFNULL(posts.updated_at, IFNULL(tweets.updated_at,'')) desc", :limit => limit)
  end

  def juggernaut_channel
    "folder_#{self.id}"
  end

end
