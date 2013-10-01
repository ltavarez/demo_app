class Usuario < ActiveRecord::Base
  validates :nombre, presence: true , length: {maximum: 50}
  validates :email,  presence: true, uniqueness: {case_sensitive: false}
end
