class Minipost < ActiveRecord::Base
  belongs_to :usuario
  validates :usuario_id , presence: true
  validates :content , presence: true ,  length: { maximum: 140 }
  default_scope -> { order('created_at DESC') }

end
