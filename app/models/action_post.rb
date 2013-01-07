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
    diff = (self.end_date.to_time()-self.start_date.to_time())
    return diff
  end

  def action
    Action.find(action_id)
  end
  
  def date_sort
    self.start_date
  end
end
