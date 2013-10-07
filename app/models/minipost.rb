class Minipost < ActiveRecord::Base
  belongs_to :usuario
  validates :usuario_id , presence: true
  validates :content , presence: true ,  length: { maximum: 140 }
  default_scope -> { order('created_at DESC') }
 
 def self.from_users_followed_by(usuario)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :usuario_id"
    where("usuario_id IN (#{followed_user_ids}) OR usuario_id = :usuario_id",
          usuario_id: usuario.id)
  end

end
