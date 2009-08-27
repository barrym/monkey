# == Schema Information
# Schema version: 20090827202915
#
# Table name: links
#
#  id         :integer(4)      not null, primary key
#  domain_id  :integer(4)
#  url        :string(255)
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Link < ActiveRecord::Base

  has_many :shared_links
  belongs_to :domain
end
