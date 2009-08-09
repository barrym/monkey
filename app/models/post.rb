# == Schema Information
# Schema version: 20090809102952
#
# Table name: posts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  name       :string(255)
#  subject    :string(255)
#  body       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base

  # belongs_to :folder
  belongs_to :user
  has_many :comments, :foreign_key => :entity_id

end
