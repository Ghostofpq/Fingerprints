# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#
class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  has_many :microposts, dependent: :destroy
  has_many :action_posts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :authorizations, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name,  presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:     true,
                    format:       { with: VALID_EMAIL_REGEX },
                    uniqueness:   true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates_confirmation_of :password

  def feed
    Micropost.from_users_followed_by(self)
  end

  def action_feed
    ActionPost.from_users_followed_by(self)
  end

  def self_action_feed
    ActionPost.from_user_only(self)
  end

  def self_feed
    Micropost.from_user_only(self)
  end

  def self_action_feed_public
    ActionPost.public_ones(self)
  end

  def self_feed_public
    Micropost.public_ones(self)
  end

  def user_doing(action_id)
    ActionPost.from_user_only_doing(self,action_id)
  end

  def total_time_doing(action_name)
    @action=self.user_doing(Action.find_by_name(action_name).id)
    @total_time=0
    @action.each do |x| @total_time += x.duration() end
    return @total_time
  end

  def add_provider(auth_hash)
    if has_not_provider(auth_hash["provider"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end

  def has_not_provider(provider_name)
    return (authorizations.find_by_provider(provider_name)==nil)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def publish(action_post, feed_name)
    begin
      text= "Test test test " + action_post.action.name + " bliblablou " + action_post.start_date.to_date().to_formatted_s(:short)
      text+= " bler bloux blix " + action_post.end_date.to_date().to_formatted_s(:short)
      case self.provider
      when 'facebook' then facebook.feed!(:message => @text, :name => feed_name)
      #when 'twitter' then twitter.request(:post, "http://api.twitter.com/1/statuses/update.json", :status => text)
      end
    rescue Exception => e
    end
  end
end
