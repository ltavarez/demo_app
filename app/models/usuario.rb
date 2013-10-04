class Usuario < ActiveRecord::Base
  before_save {self.email = email.downcase}
  before_create :create_remember_token
  validates :nombre, presence: true , length: {maximum: 50}
  validates :email,  presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: { minimum: 6 }
  has_paper_trail
  has_many :miniposts, dependent: :destroy
  #has_secure_password
  
   def Usuario.new_remember_token
     SecureRandom.urlsafe_base64
   end
   
    # This is preliminary. See "Following users" for the full implementation.
   def feed    
    Minipost.where("usuario_id = ?", id)
   end

  def Usuario.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private

  def create_remember_token
     self.remember_token = Usuario.encrypt(Usuario.new_remember_token)
  end
  
end
