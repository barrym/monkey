# == Schema Information
# Schema version: 20090827202915
#
# Table name: domains
#
#  id         :integer(4)      not null, primary key
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Domain < ActiveRecord::Base
  has_many :links
end
