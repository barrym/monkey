# == Schema Information
# Schema version: 20090809102952
#
# Table name: replies
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  post_id    :integer(4)
#  name       :string(255)
#  body       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
end
