class Action < ActiveRecord::Base
  attr_accessible :name, :pic_path,:category
  
  validates :name, presence: true
  validates :pic_path, presence: true
  validates :category, presence: true
end
