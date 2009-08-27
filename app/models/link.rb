class Link < ActiveRecord::Base

  has_many :shared_links
  belongs_to :domain
end
