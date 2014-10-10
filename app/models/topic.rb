class Topic < ActiveRecord::Base
  belongs_to  :user
  has_many    :bookmarks

  default_scope {order('name')}

  def liked_bookmarks(cur_usr)
            


    liked_bookmark_ids = cur_usr.likes.pluck(:bookmark_id)
    bookmarks.where(id:liked_bookmark_ids).order('created_at DESC')
  end

end

#liked_bookmark_ids = current_user.likes.pluck(:bookmark_id)
#@liked_bookmarks = Bookmark.joins(:topic).where(id:liked_bookmark_ids).order('topics.name').order('created_at DESC')