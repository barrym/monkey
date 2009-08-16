class Category < ActiveRecord::Base
  has_many :categorised_entities
end
