# == Schema Information
# Schema version: 20090827202915
#
# Table name: categorised_entities
#
#  id          :integer(4)      not null, primary key
#  category_id :integer(4)
#  entity_id   :integer(4)
#  entity_type :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class CategorisedEntity < ActiveRecord::Base
  belongs_to :category
  belongs_to :entity, :polymorphic => true
end
