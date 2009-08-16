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
    self.category_ids.map{|id| "category_#{id}"}
  end

  private

  def update_categorised_entities
    ids = self.category_ids
    puts "Updating cat ents for #{self.inspect}"
    puts "cat_ids = #{ids.inspect}"
    CategorisedEntity.delete_all(:entity_type => self.class.to_s, :entity_id => self.id)
    ids.each do |category_id|
      foo = CategorisedEntity.create(:category => Category.find(category_id), :entity => self)
      puts "created #{foo.inspect}"
    end
  end

end
