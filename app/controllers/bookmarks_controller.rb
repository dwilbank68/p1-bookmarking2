class BookmarksController < ApplicationController
  def destroy
    @bookmark = Bookmark.find(params[:id])
    url = @bookmark.url
    authorize @bookmark

    if @bookmark.destroy
      flash[:notice] = "\"#{url}\" was deleted successfully."
      redirect_to :back
    else
      flash[:error] = "There was an error deleting the bookmark."
      render :back
    end
  end
end
