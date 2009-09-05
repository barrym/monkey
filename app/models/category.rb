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

  named_scope :non_system, :conditions => { :system => false }, :order => :name

  def entities(options = {})
    raise "Wah! Need :page and :per_page" unless options[:page] && options[:per_page]
    # self.categorised_entities.find(:all, :include => :entity, :order => "updated_at desc", :group => "entity_type, entity_id").map {|ce| ce.entity}
    self.categorised_entities.paginate(:page => options[:page],
                                       :per_page => options[:per_page],
                                       :include => :entity,
                                       :order => "updated_at desc",
                                       :group => "entity_type, entity_id"
                                      )
  end

end
