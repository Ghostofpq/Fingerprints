class Micropost < ActiveRecord::Base
  attr_accessible :desc, :user_id
end
