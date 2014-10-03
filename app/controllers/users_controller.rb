class UsersController < ApplicationController

  def show
    @bookmarks = current_user.bookmarks
    @bookmarks
  end

end