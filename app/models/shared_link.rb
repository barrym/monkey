# == Schema Information
# Schema version: 20090827202915
#
# Table name: shared_links
#
#  id           :integer(4)      not null, primary key
#  link_id      :integer(4)
#  user_id      :integer(4)
#  original_url :string(255)
#  source_url   :string(255)
#  source_name  :string(255)
#  body         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

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
