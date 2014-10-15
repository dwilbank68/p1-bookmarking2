class Topic < ActiveRecord::Base
  belongs_to  :user
  has_many    :bookmarks

  validates :name, { :uniqueness => true }

  before_destroy :check_for_bookmarks

  default_scope {order('name')}

  def liked_bookmarks(cur_usr)
    return nil unless cur_usr
    liked_bookmark_ids = cur_usr.likes.pluck(:bookmark_id)
    bookmarks.where(id:liked_bookmark_ids).order('created_at DESC')
  end

  def check_for_bookmarks
    if bookmarks.any?
      errors[:base] << "cannot delete submission that has already been paid"
      return false
    end
  end

end

#liked_bookmark_ids = current_user.likes.pluck(:bookmark_id)
#@liked_bookmarks = Bookmark.joins(:topic).where(id:liked_bookmark_ids).order('topics.name').order('created_at DESC')