class User < ActiveRecord::Base
  attr_accessible :email, :name
  
  before_save { |user| user.email = email.downcase }
  
  validates :name,  presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  
  has_many :microposts
end
