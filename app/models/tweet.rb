# == Schema Information
# Schema version: 20090827202915
#
# Table name: tweets
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  body       :string(255)
#  tweeted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Tweet < ActiveRecord::Base

  include EntityAbstract

  belongs_to :user
  has_many :comments, :foreign_key => :entity_id, :as => :entity
  # belongs_to :categorised_entity

  after_save :update_user_entities

  private

  def update_user_entities
    self.user.entities << self
  end

end
