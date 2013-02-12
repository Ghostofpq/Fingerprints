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

  has_and_belongs_to_many  :achievements

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

  def user_doing(activity_id)
    ActionPost.from_user_only_doing(self,activity_id)
  end

  def total_time_doing(activity_name)
    @activity=self.user_doing(Activity.find_by_name(activity_name).id)
    @total_time=0
    @activity.each do |x| @total_time += x.duration() end
    return @total_time
  end

  def total_spent_doing(action_name)
    @activity=self.user_doing(Activity.find_by_name(activity_name).id)
    @total_spent=0.to_f
    @activity.each do |x|
      @total_spent =@total_spent+ x.get_price()
    end
    return @total_spent
  end

  def favourite_actions(number)
    activities=[]
    self.action_posts.each do |action_post|
      unless activities.include?(action_post.action)
      activities<<action_post.action
      end
    end
    p=[]
    activities.each do |activity|
      p<<[activity.id,self.action_posts.where(:activity_id=>activity.id).count]
    end
    p.sort_by! do |obj1| -obj1.last end
    a=[]
    p.each do |item|
      a<<Activity.find(item.first)
    end
    return a.first(number)
  end

  #PROVIDERS STUFF
  def has_provider(provider_name)
    return (authorizations.find_by_provider(provider_name)!=nil)
  end

  def has_not_provider(provider_name)
    return (authorizations.find_by_provider(provider_name)==nil)
  end

  def add_provider(auth_hash)
    if has_not_provider(auth_hash["provider"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"],:token => (auth_hash["credentials"]["token"] rescue nil)
    end
  end

  def facebook
    @fb_user ||= FbGraph::User.me(self.authorizations.find_by_provider('facebook').token)
  end

  def publish(action_post, feed_name)
    if(action_post.start_date.to_date().today?)
      text="Today, "
    elsif(action_post.start_date.to_date().yesterday?)
      text="Yesterday, "
    else
      text="On "+action_post.start_date.to_date().to_s(:long_ordinal)+", "
    end
    text+="I have "+ action_post.activity.past_participle

    facebook.feed!(
    :message => text,
    :name => 'My Rails 3 App with Omniauth, Devise and FB_graph'
    )
  end

  #FOLLOW STUFF
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

  #ACHIEVEMENTS STUFF
  def unlocks!(achievement)
    self.achievements<<achievement
  end

  def has_achievement(achievement_id)
    return ((self.achievements.find(achievement_id) rescue nil)!=nil)
  end

end
