class Folder < ActiveRecord::Base

  validates_presence_of :name, :user

  belongs_to :user

  # def to_param
  #   "thisisahash"
  # end

end
