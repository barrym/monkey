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
  after_create :send_to_juggernaut

  def self.share(data)
    raise "No URL in shared link" unless data[:url]
    link = Link.find_or_create_by_url(:url => data.delete(:url), :title => data.delete(:title))
    unless self.find(:first, :conditions => {:link_id => link.id, :user_id => data[:user].id})
      data[:link] = link
      self.create!(data.merge(:category_ids => [Category::SHARED_LINK_CATEGORY.id]))
    end
  end

  private

  def update_user_entities
    self.user.entities << self
  end

  def send_to_juggernaut
    Juggernaut.send_to_channels("displayNewSharedLink('#{self.id}');", self.juggernaut_channels)
  end

end
