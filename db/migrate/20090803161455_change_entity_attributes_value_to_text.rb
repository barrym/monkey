class ChangeEntityAttributesValueToText < ActiveRecord::Migration
  def self.up
    change_column :entity_attributes, :value, :text
  end

  def self.down
  end
end
