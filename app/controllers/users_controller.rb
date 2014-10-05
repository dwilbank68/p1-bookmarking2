class UsersController < ApplicationController

  def show
    liked_bookmark_ids = current_user.likes.pluck(:bookmark_id)
    @liked_bookmarks = Bookmark.joins(:topic).where(id:liked_bookmark_ids).order('topics.name').order('created_at DESC')
    #@liked_bookmarks = Bookmark.all
  end

end

#.joins(:topic).order('topics.name')