# == Schema Information
# Schema version: 20090715193517
#
# Table name: entities
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  folder_id  :integer(4)
#  parent_id  :integer(4)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Entity < ActiveRecord::Base

  belongs_to :user
  belongs_to :folder
  belongs_to :parent, :foreign_key => :parent_id, :class_name => "Entity"
  has_many :children, :foreign_key => :parent_id, :class_name => "Entity"

  has_many :entity_attributes

  validates_presence_of :user

  after_save :save_attributes

  ATTRIBUTES = []

  def initialize(*params)
    params.first.each do |attr, value|
      if self.class::ATTRIBUTES.include?(attr.to_sym)
        self.send("#{attr}=", value)
        params.first.delete(attr)
      end
    end if params.first
    super *params
  end

  def recent_children(limit = 20)
    self.children.find(:all, :order => 'id desc', :limit => limit)
  end

  private

  def save_attributes
    old_attrs = {}
    self.entity_attributes.each do |attr|
      old_attrs[attr.key] = attr.value
    end
    self.entity_attributes.destroy_all
    attrs_to_save = old_attrs.merge(@entity_attributes_cache || {})
    self.class::ATTRIBUTES.each do |attr|
      if value = attrs_to_save[attr]
        self.entity_attributes.create(:key => attr.to_s, :value => value)
      end
    end
  end

  def method_missing(symbol, *args)
    logger.info("#{self} called #{symbol} with #{args}")
    # TODO : seriously rethink this. Maybe ;)
    bare_symbol = symbol.to_s.gsub(/=$/,'').to_sym
    if self.class::ATTRIBUTES.include?(bare_symbol)
      @entity_attributes_cache ||= {}
      # This is a getter or a setter for an attribute
      if symbol == bare_symbol
        # It's a getter
        if @entity_attributes_cache.has_key?(symbol)
          @entity_attributes_cache[symbol]
        elsif db_attr = self.entity_attributes.find_by_key(symbol.to_s)
          @entity_attributes_cache[symbol] = db_attr.value
        else
          @entity_attributes_cache[symbol] = nil
        end
      else
        # It's a setter
        @entity_attributes_cache[bare_symbol] = args.first
      end
    else
      super
    end
  end

end
