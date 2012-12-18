class Action < ActiveRecord::Base
  attr_accessible :name, :pic_path,:category,:has_price,:has_place,:has_score,:has_comment,:has_duration

  validates :name, presence: true
  validates :pic_path, presence: true
  validates :category, presence: true
end
