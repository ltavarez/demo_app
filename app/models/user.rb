class User < ActiveRecord::Base
  validates :name, presence: true , length: {maximum: 50}
  validates :email,  presence: true, uniqueness: {case_sensitive: false}
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  validates :password, length: { minimum: 6 }
  has_many :microposts
  has_paper_trail
end
