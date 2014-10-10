class LikesController < ApplicationController

  def destroy
    unliked = Like.where(user_id:params[:id], bookmark_id:params[:bookmark_id])
    unliked[0].destroy
    puts "*"*30
    puts params.inspect
    puts "*"*30
    redirect_to :back
  end

end