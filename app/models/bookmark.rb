class Bookmark < ActiveRecord::Base

  belongs_to  :topic
  has_many    :likes, dependent: :destroy
  belongs_to  :user
  validates_with UrlValidator# on: :url
  validates :topic, presence: true
  validates :user, presence: true

  def liked?(current_user,bookmark)
    return false unless current_user
    Like.where(bookmark_id: bookmark.id, user_id: current_user.id).count > 0 ? "liked-#{bookmark.topic.color}":""
  end

end
