# == Schema Information
# Schema version: 20090715193517
#
# Table name: entity_attributes
#
#  id         :integer(4)      not null, primary key
#  entity_id  :integer(4)
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class EntityAttribute < ActiveRecord::Base

  belongs_to :entity

end
