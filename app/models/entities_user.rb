class EntitiesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :entity, :polymorphic => true
end
