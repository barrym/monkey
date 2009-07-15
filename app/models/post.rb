# == Schema Information
# Schema version: 20090715185048
#
# Table name: things
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  folder_id  :integer(4)
#  parent_id  :integer(4)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Post < Thing

end
