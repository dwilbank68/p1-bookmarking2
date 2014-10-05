class Bookmark < ActiveRecord::Base
  belongs_to  :topic
  has_many    :likes, dependent: :destroy
  belongs_to  :user
  validates :url, :presence => true, :length => { :minimum =>2, :maximum => 255 }
  validates :topic, presence: true
  validates :user, presence: true

  #default_scope {order('created_at DESC')}
  #default_scope {order('topic.name DESC')}

end
