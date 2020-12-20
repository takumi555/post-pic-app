class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build

    @comments = @post.comments
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save!
      redirect_to posts_path, notice: '投稿できました'
    else
      flash.now[:error] = '投稿できませんでした'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, notice: '削除に成功しました'
  end

  private
  def post_params
    params.require(:post).permit(:content, pictures: [])
  end

end