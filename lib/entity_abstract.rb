module EntityAbstract

  # validates presence of category ids

  def self.included(base)
    base.class_eval("after_save :update_categorised_entities")
  end

  def categories
    CategorisedEntity.find(:all, :conditions => {:entity_type => self.class.to_s, :entity_id => self.id}).map{|ce| ce.category}
  end

  def category_ids
    @category_ids ||= CategorisedEntity.find(:all, :conditions => {:entity_type => self.class.to_s,:entity_id => self.id}).map {|ce| ce.category_id}
  end

  def category_ids=(category_ids)
    @category_ids = category_ids
  end

  def juggernaut_channels
    category_ids = self.category_ids.map{|id| "category_#{id}"}
    entity_id = "#{self.class.to_s.underscore}_#{self.id}"
    category_ids + [entity_id]
  end

  private

  def update_categorised_entities
    ids = self.category_ids
    CategorisedEntity.delete_all(:entity_type => self.class.to_s, :entity_id => self.id)
    ids.each do |category_id|
      CategorisedEntity.create(:category => Category.find(category_id), :entity => self)
    end
  end

end
