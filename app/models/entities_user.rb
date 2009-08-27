# == Schema Information
# Schema version: 20090827202915
#
# Table name: entities_users
#
#  id          :integer(4)      not null, primary key
#  entity_id   :integer(4)
#  entity_type :string(255)
#  user_id     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class EntitiesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity, :polymorphic => true
end
