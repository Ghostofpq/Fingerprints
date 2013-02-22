class Activity < ActiveRecord::Base
  attr_accessible :name,:past_participle, :pic_path,:category,:has_price,:has_place,:has_score,:has_comment,:has_duration

  has_and_belongs_to_many  :achievements

  validates :name, presence: true
  validates :past_participle, presence: true
  validates :pic_path, presence: true
  validates :category, presence: true
  
  def references!(achievement)
    self.achievements<<achievement
  end
end
