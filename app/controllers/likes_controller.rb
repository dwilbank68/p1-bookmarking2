class LikesController < ApplicationController
  respond_to :html, :js

  def create
    @like = Like.create(
        user_id:current_user.id,
        bookmark_id:params[:bookmark_id]
    )
    @bookmark = Bookmark.find(params[:bookmark_id])
    @current_user = current_user
    respond_with(@like) do |format|
      format.html { redirect_to :back }
    end

  end

  def destroy
    @like = Like.where(user_id:params[:id], bookmark_id:params[:bookmark_id])
    @bookmark_liked_id = params[:bookmark_id]
    @bookmark = Bookmark.find(@bookmark_liked_id)
    #authorize @like

    if @like[0].destroy
      flash[:notice] = "Like was deleted successfully."
    else
      flash[:error] = "There was an error deleting the like."
    end

    respond_with(@like[0]) do |format|
      format.html { redirect_to :back }
    end
  end

end







