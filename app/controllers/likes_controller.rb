class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)

    if !like.save
      flash[:notice] = @like.errors.full_messages.to_s
    end

    redirect_to @like.comment
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    comment = @like.post
    @like.destroy
    redirect_to comment
  end


  private

  def like_params
    binding.pry
    params.require(:like).permit(:post_id)
  end
end
