# == Schema Information
#
# Table name: action_posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  action_id  :integer
#  start_date :datetime
#  end_date   :datetime
#  comment    :string(255)
#  place      :string(255)
#  score      :integer
#  price      :decimal(8, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public     :boolean          default(FALSE)
#
class ActionPost < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :comment, :place, :score, :price,:action_id,:public

  belongs_to :user

  validates :user_id, presence: true
  validates :action_id, presence: true

  default_scope order: 'action_posts.start_date DESC'
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("(user_id IN (#{followed_user_ids}) AND public = :public) OR user_id = :user_id",
          user_id: user.id, public: true)
  end

  def self.from_user_only(user)
    where("user_id = :user_id", user_id: user.id)
  end

  def self.from_user_only_doing(user,action_id)
    where("user_id = :user_id and action_id=:action_id", user_id: user.id,action_id: action_id)
  end

  def self.public_ones(user)
    where("public = :public AND user_id = :user_id",user_id: user.id, public: true)
  end

  def get_price
    if self.price==nil
    return 0.to_f
    end
    return self.price.to_f
  end

  def duration
    diff = (self.end_date.to_time-self.start_date.to_time)
    return diff
  end

  def score_img
    if self.score==0
      return "F.jpg"
    elsif self.score==1
      return "E_moins.jpg"
    elsif self.score==2
      return "E.jpg"
    elsif self.score==3
      return "D_moins.jpg"
    elsif self.score==4
      return "D.jpg"
    elsif self.score==5
      return "C.jpg"
    elsif self.score==6
      return "C.jpg"
    elsif self.score==7
      return "B.jpg"
    elsif self.score==8
      return "B_plus.jpg"
    elsif self.score==9
      return "A.jpg"
    elsif self.score==10
      return "A_plus.jpg"
    end
  end

  def is_on_one_day
    return (local_start_date.to_date==local_end_date.to_date)
  end

  def local_start_date
    return DateTime.civil_from_format(:utc,self.start_date.year,self.start_date.month,self.start_date.day,self.start_date.hour,self.start_date.min)
  end

  def local_end_date
    return DateTime.civil_from_format(:utc,self.end_date.year,self.end_date.month,self.end_date.day,self.end_date.hour,self.end_date.min)
  end

  def action
    Action.find(action_id)
  end

  def date_sort
    self.start_date
  end
end
