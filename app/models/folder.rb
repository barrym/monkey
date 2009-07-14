class Folder < ActiveRecord::Base

  validates_presence_of :name, :user

  belongs_to :user
end
