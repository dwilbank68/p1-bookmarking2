class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    if params[:id] == current_user.id.to_s
      liked_bookmark_ids = current_user.likes.pluck(:bookmark_id)
      liked_bookmarks = Bookmark.where(id:liked_bookmark_ids)

      @current_user = current_user

      @liked_bookmarks = liked_bookmarks.joins(:topic).order('topics.name').order('created_at DESC')
    else
       redirect_to current_user, notice: "Stick to your own page"
    end
  end

end
