class PostStuff
  def initialize(params)
    @params = params
  end

  def create
    @post = Post.new(post_params.except :mediums_attributes)
    return @post unless @post.save
    save_the_media
    @post
  end

  def update(post)
    @post = post
    return @post, false unless @post.update(post_params.except :mediums_attributes)
    save_the_media
    return @post, true
  end

  def save_the_media
    return unless post_params[:mediums_attributes]
    media_params = post_params[:mediums_attributes]["0"] || post_params[:mediums_attributes]
    return unless media_params && media_params[:attachment]
    media_params[:attachment].each{ |attachment| @post.mediums.create(attachment: attachment) }
  end

  def post_params
    ActionController::Parameters.new(@params).require(:post).permit(:title, :body, :user_id,mediums_attributes:[:attachment])
  end
end
