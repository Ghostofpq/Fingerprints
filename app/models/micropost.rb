# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public     :boolean          default(FALSE)
#
class Micropost < ActiveRecord::Base
  attr_accessible :content

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
end
