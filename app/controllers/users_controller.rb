class UsersController < ApplicationController

  def show
    liked_bookmark_ids = current_user.likes.pluck(:bookmark_id)
    liked_bookmarks = Bookmark.where(id:liked_bookmark_ids)
    liked_topic_ids = liked_bookmarks.pluck(:topic_id)
    @liked_topics = Topic.where(id:liked_topic_ids).order('topics.name')
    #@liked_bookmarks = Bookmark.all
  end

end

#.joins(:topic).order('topics.name')