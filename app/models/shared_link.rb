class SharedLink < ActiveRecord::Base
  include EntityAbstract

  belongs_to :user
  belongs_to :link
  has_many :comments, :foreign_key => :entity_id, :as => :entity
  # belongs_to :categorised_entity

  after_save :update_user_entities

  private

  def update_user_entities
    self.user.entities << self
  end

end
