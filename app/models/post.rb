# == Schema Information
# Schema version: 20090809102952
#
# Table name: posts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  name       :string(255)
#  subject    :string(255)
#  body       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base

  belongs_to :user
  has_many :comments, :foreign_key => :entity_id, :as => :entity
  # belongs_to :categorised_entity

  after_save :update_user_entities
  after_save :update_categorised_entities

  # validates presence of category ids

  def categories
    CategorisedEntity.find(:all, :conditions => {:entity_id => self.id})
  end

  def category_ids
    @category_ids ||= CategorisedEntity.find(:all, :conditions => {:entity_id => self.id}).map {|ce| c.id}
  end

  def category_ids=(category_ids)
    @category_ids = category_ids
  end

  private

  def update_categorised_entities
    CategorisedEntity.delete_all(:entity_id => self.id)
    category_ids.each do |category_id|
      CategorisedEntity.create(:category => Category.find(category_id), :entity => self)
    end
  end

  def update_user_entities
    self.user.entities << self
  end

end
