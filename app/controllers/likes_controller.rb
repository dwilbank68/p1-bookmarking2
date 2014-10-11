class LikesController < ApplicationController

  def create
    Like.create(
        user_id:current_user.id,
        bookmark_id:params[:bookmark_id]
    )
    redirect_to :back
  end

  def destroy
    unliked = Like.where(user_id:params[:id], bookmark_id:params[:bookmark_id])
    unliked[0].destroy
    puts "*"*30
    puts params.inspect
    puts "*"*30
    redirect_to :back
  end

end