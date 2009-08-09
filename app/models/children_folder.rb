# == Schema Information
# Schema version: 20090809102952
#
# Table name: children_folders
#
#  id         :integer(4)      not null, primary key
#  child_id   :integer(4)
#  child_type :string(255)
#  folder_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class ChildrenFolder < ActiveRecord::Base
  belongs_to :folder
  belongs_to :child, :polymorphic => true
end
