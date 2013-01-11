# == Schema Information
#
# Table name: actions
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  category     :string(255)
#  pic_path     :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  has_price    :boolean          default(FALSE)
#  has_place    :boolean          default(FALSE)
#  has_score    :boolean          default(FALSE)
#  has_comment  :boolean          default(FALSE)
#  has_duration :boolean          default(FALSE)
#
class Action < ActiveRecord::Base
  attr_accessible :name, :pic_path,:category,:has_price,:has_place,:has_score,:has_comment,:has_duration

  has_and_belongs_to_many  :achievements

  validates :name, presence: true
  validates :pic_path, presence: true
  validates :category, presence: true
  
  def references!(achievement)
    self.achievements<<achievement
  end
end
