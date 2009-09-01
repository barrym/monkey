# == Schema Information
# Schema version: 20090827202915
#
# Table name: categories
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  system      :boolean(1)
#  created_at  :datetime
#  updated_at  :datetime
#

class Category < ActiveRecord::Base

  has_many :categorised_entities

  SHARED_LINK_CATEGORY = self.find_by_name('Shared Links')

  def entities
    self.categorised_entities.find(:all, :include => :entity, :order => "updated_at desc", :group => "entity_type, entity_id").map {|ce| ce.entity}
  end

end
