class Usuario < ActiveRecord::Base
  before_save {self.email = email.downcase}
  validates :nombre, presence: true , length: {maximum: 50}
  validates :email,  presence: true, uniqueness: {case_sensitive: false}
end
