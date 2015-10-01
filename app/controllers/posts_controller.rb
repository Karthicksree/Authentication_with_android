class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    # @posts = Post.all
    # respond_with(@posts)

    @post = Post.new
    @post.mediums.build
    respond_with(@post)
  end

  def show
    respond_with(@post)
    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     render pdf: "post",template: "posts/show.html.erb"
    #   end
    # end
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.save
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end
end
