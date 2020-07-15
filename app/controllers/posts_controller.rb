class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only:[:user_post, :edit, :update, :destroy, :show]

  def index
    @posts=Post.all
  end

  def my_post 
    @posts = current_user.posts.all
  end

  def user_post
    @user = @post.user
    @posts = @user.posts.all
  end
  
  def new
    @post = Post.new
  end
  
  
  def create
    @post = Post.new(posts_params)
    @post.user = current_user
    if @post.save
      redirect_to root_path, notice: "投稿しました！"
    else
      render :new
    end
  end
  
  def show
    @like = Like.new
  end
  
  def edit
  end
  
  def update
    @post.update(posts_params)
    redirect_to("/")
  end
  
  def destroy
    @post.destroy
    redirect_to("/my_post")
  end

  def like 
    @posts = Post.all
    @user = current_user
  end
  
  
  private
  def set_post
    @post = Post.find(params[:id])
  end

  def posts_params
    params.require(:post).permit( :title, :text, :img, :url, :user_id)
  end

  
end
