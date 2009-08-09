class ChildrenFolder < ActiveRecord::Base
  belongs_to :folder
  belongs_to :child, :polymorphic => true
end
