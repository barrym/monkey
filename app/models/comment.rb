# == Schema Information
# Schema version: 20090827202915
#
# Table name: comments
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  entity_id   :integer(4)
#  entity_type :string(255)
#  body        :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :entity, :polymorphic => true
  belongs_to :user

  after_save :update_user_entities, :touch_parent

  private

  def update_user_entities
    self.user.entities << self
  end

  def touch_parent
    self.entity.update_attributes(:updated_at => Time.now)
  end

end
