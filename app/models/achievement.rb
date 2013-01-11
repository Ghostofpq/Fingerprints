class Achievement < ActiveRecord::Base
  attr_accessible :name,:pic_path

  has_and_belongs_to_many  :actions
  has_and_belongs_to_many  :users
end
