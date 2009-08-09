# == Schema Information
# Schema version: 20090809102952
#
# Table name: comments
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  entity_id  :integer(4)
#  body       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  after_save :update_entities

  private
  def update_entities
    self.user.entities << self
  end
end
