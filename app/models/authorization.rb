class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid
  belongs_to :user

  validates :provider,presence: true
  validates :uid, presence: true
  validates :user_id, presence: true
  
  def self.find(auth_hash)
    auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  end
end
