class UsersController < ApplicationController

  def show
    if params[:id] == current_user.id.to_s
      liked_bookmark_ids = current_user.likes.pluck(:bookmark_id)
      liked_bookmarks = Bookmark.where(id:liked_bookmark_ids)
      liked_topic_ids = liked_bookmarks.pluck(:topic_id)
      @current_user = current_user
      @liked_topics = Topic.where(id:liked_topic_ids).order('topics.name')
        # this jumps straight to topics/_topic.html.erb instead of topics/show.html.erb
      @liked_bookmarks = liked_bookmarks # this is an un-sorted test array just to get masonry working
    else
       redirect_to current_user, notice: "Stick to your own page"
    end
  end

end

#.joins(:topic).order('topics.name')