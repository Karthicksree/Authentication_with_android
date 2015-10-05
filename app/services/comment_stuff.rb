class CommentStuff
  def initialize(params)
    @params = params
  end

  def create
    @comment = Comment.new(comment_params.except :mediums_attributes)
    return @comment unless @comment.save
    save_the_media
    @comment
  end

  def update(comment)
    @comment = comment
    return @comment, false unless @comment.update(comment_params.except :mediums_attributes)
    save_the_media
    return @comment, true
  end

  def save_the_media
    return unless comment_params[:mediums_attributes]
    media_params = comment_params[:mediums_attributes]["0"] || comment_params[:mediums_attributes]
    return unless media_params && media_params[:attachment]
    media_params[:attachment].each{ |attachment| @comment.mediums.create(attachment: attachment) }
  end

  def comment_params
    ActionController::Parameters.new(@params).require(:comment).permit(:body, :user_id, :post_id,mediums_attributes:[:attachment])
  end
end
