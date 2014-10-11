class Bookmark < ActiveRecord::Base
  belongs_to  :topic
  has_many    :likes, dependent: :destroy
  belongs_to  :user
  validates :url, :presence => true, :length => { :minimum =>2, :maximum => 255 }
  validates :topic, presence: true
  validates :user, presence: true

  #default_scope {order('created_at DESC')}
  #default_scope {order('topic.name DESC')}

  def liked?
    #Like.where(bookmark_id: id, user_id: current_user.id) ? "liked":""
    Like.where(bookmark_id: id, user_id: 6).count > 0 ? "liked":""
  end

end
