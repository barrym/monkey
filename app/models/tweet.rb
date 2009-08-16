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
