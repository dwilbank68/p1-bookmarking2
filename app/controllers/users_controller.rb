class UsersController < ApplicationController

  def show
    @topics = Topic.all
    @bookmarks = current_user.bookmarks
    @bookmarks
  end

end