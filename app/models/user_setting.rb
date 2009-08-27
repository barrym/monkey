# == Schema Information
# Schema version: 20090827202915
#
# Table name: user_settings
#
#  id                    :integer(4)      not null, primary key
#  user_id               :integer(4)
#  display_mode          :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  google_reader_url     :text
#  friendfeed_username   :string(255)
#  friendfeed_remote_key :string(255)
#

class UserSetting < ActiveRecord::Base

  belongs_to :user

end
