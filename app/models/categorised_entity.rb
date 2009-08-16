class CategorisedEntity < ActiveRecord::Base
  belongs_to :category
  belongs_to :entity, :polymorphic => true
end
