class BookmarksController < ApplicationController

  respond_to :html, :js

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
      format.html { redirect_to :back } # is this limiting itself to one view? I have 3 that need ajax destroy
    end

  end
end
