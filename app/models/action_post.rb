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
end
