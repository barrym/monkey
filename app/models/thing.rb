# == Schema Information
# Schema version: 20090715185048
#
# Table name: things
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  folder_id  :integer(4)
#  parent_id  :integer(4)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Thing < ActiveRecord::Base

  belongs_to :user
  belongs_to :folder

  has_many :thing_attributes

  validates_presence_of :user
  validates_presence_of :folder

  after_save :save_attributes

  private

  def save_attributes
    old_attrs = {}
    self.thing_attributes.each do |attr|
      old_attrs[attr.key] = attr.value
    end
    self.thing_attributes.destroy_all
    attrs_to_save = old_attrs.merge(@thing_attributes_cache || {})
    self.class::ATTRIBUTES.each do |attr|
      if value = attrs_to_save[attr]
        self.thing_attributes.create(:key => attr.to_s, :value => value)
      end
    end
  end

  def method_missing(symbol, *args)
    # TODO : seriously rethink this. Maybe ;)
    bare_symbol = symbol.to_s.gsub(/=$/,'').to_sym
    if self.class::ATTRIBUTES.include?(bare_symbol)
      @thing_attributes_cache ||= {}
      # This is a getter or a setter for an attribute
      if symbol == bare_symbol
        # It's a getter
        if @thing_attributes_cache.has_key?(symbol)
          @thing_attributes_cache[symbol]
        elsif db_attr = self.thing_attributes.find_by_key(symbol.to_s)
          @thing_attributes_cache[symbol] = db_attr.value
        else
          @thing_attributes_cache[symbol] = nil
        end
      else
        # It's a setter
        @thing_attributes_cache[bare_symbol] = args.first
      end
    else
      super
    end
  end


end
