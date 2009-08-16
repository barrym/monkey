class Tweet < ActiveRecord::Base

  belongs_to :user
  has_many :comments, :foreign_key => :entity_id, :as => :entity
  # belongs_to :categorised_entity

  after_save :update_entities

  private
  def update_entities
    self.user.entities << self
  end

end
