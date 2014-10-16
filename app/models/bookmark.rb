#include ActiveModel::UrlValidator

class Bookmark < ActiveRecord::Base

  belongs_to  :topic
  has_many    :likes, dependent: :destroy
  belongs_to  :user
  # validates :url, :presence => true, :length => { :minimum =>2, :maximum => 255 }
  #validates_with UrlValidator# on: :url
  #validates :url, :presence => true, :url => true
  #validates :url, true # custom - see app/validators/url_validator.rb
  # validates :topic, presence: true
  # validates :user, presence: true


  #default_scope {order('created_at DESC')}
  #default_scope {order('topic.name DESC')}

  def liked?(current_user,bookmark)
    return false unless current_user
    #Like.where(bookmark_id: id, user_id: current_user.id) ? "liked":""
    Like.where(bookmark_id: bookmark.id, user_id: current_user.id).count > 0 ? "liked":""
  end

end
