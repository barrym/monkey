class Category < ActiveRecord::Base
  has_many :categorised_entities

  def entities
    self.categorised_entities.find(:all, :include => :entity, :order => "updated_at desc", :group => "entity_type, entity_id").map {|ce| ce.entity}
  end

end
