class BookmarksController < ApplicationController

  respond_to :html, :js

  def index
    @bookmarks = Bookmark.joins(:topic).order('topics.name').order('created_at DESC')
    @current_user = current_user
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark

    if @bookmark.destroy
      skip_annoying_flash = true
      @bookmark.topic.destroy if @bookmark.topic.bookmarks.count == 0
    else
      flash[:error] = "There was an error deleting the bookmark."
    end

    respond_with(@bookmark) do |format|
      format.html { redirect_to :back }
    end

  end
end
