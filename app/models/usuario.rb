class Usuario < ActiveRecord::Base
  before_save {self.email = email.downcase}
  validates :nombre, presence: true , length: {maximum: 50}
  validates :email,  presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: { minimum: 6 }
  has_paper_trail
  #has_secure_password
end
