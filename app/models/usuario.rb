class Usuario < ActiveRecord::Base
  before_save {self.email = email.downcase}
  before_create :create_remember_token
  validates :nombre, presence: true , length: {maximum: 50}
  validates :email,  presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: { minimum: 6 }
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :miniposts, dependent: :destroy 
  has_paper_trail
    
   def Usuario.new_remember_token
     SecureRandom.urlsafe_base64
   end   
    # This is preliminary. See "Following users" for the full implementation.
   def feed    
    #Minipost.where("usuario_id = ?", id)
       Minipost.from_users_followed_by(self)
   end


  def Usuario.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
   def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy!
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end  
  
  private

  def create_remember_token
     self.remember_token = Usuario.encrypt(Usuario.new_remember_token)
  end
  
end
