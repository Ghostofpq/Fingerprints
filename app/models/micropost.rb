class Micropost < ActiveRecord::Base
  attr_accessible :content,:created_at

  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, :length => { :maximum => 140 }

  default_scope order: 'microposts.created_at DESC'
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("(user_id IN (#{followed_user_ids}) AND public = :public) OR user_id = :user_id",
          user_id: user.id, public: true)
  end
  
  def self.public_ones(user)
     where("public = :public AND user_id = :user_id",user_id: user.id, public: true)
  end
  
  def self.from_user_only(user)
    where("user_id = :user_id", user_id: user.id)
  end   
  
  def date_sort
    self.created_at
  end
end
