# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  desc       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Micropost < ActiveRecord::Base
  attr_accessible :desc, :user_id

  belongs_to :user

  validates :content, :length => { :maximum => 140 }
end
