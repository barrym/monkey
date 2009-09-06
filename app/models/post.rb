# == Schema Information
# Schema version: 20090827202915
#
# Table name: posts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  name       :string(255)
#  subject    :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base

  include EntityAbstract

  belongs_to :user
  has_many :comments, :foreign_key => :entity_id, :as => :entity
  # belongs_to :categorised_entity

  after_save :update_user_entities

  validates_presence_of :subject, :body

  private

  def update_user_entities
    self.user.entities << self
  end

end
