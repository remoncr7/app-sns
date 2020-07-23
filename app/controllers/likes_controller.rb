class LikesController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    @like.save
    redirect_to post_path(@post)
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
