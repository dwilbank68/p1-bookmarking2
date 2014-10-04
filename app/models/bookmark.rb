class Bookmark < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many   :likes
  validates :url, :presence => true, :length => { :minimum =>2, :maximum => 255 }

  default_scope {order('created_at DESC')}

end
