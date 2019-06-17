class PostsController < ApplicationController
  def index
    @posts = @q.result
    @users = User.all
  end

  def show
  	@post = Post.find(params[:id])
    @post_comment = PostComment.new
    @user = current_user
    # @folders = @user.folders.where(folder_id: @user.id)
    @folders = @user.folders.where(params[:folder_id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def new
  	@post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post.id)
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render root_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
  	params.require(:post).permit(:post_title, :post_text, :main_image, :user_id )
  end

end