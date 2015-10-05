module API::V1
  class CommentAPI < Base

  	helpers do 
      params :comment_fields do
      	requires :comment, type: Hash do
      		requires :post_id, type: Integer
	  			requires :body, type: String
	  			requires :user_id, type: Integer
	  			optional :mediums_attributes, type: Array do
	          requires :attachment, :type => Rack::Multipart::UploadedFile
	        end
      	end
      end
    end

  	namespace :comment do

  		desc 'create a comment'
  		params do
  			use :comment_fields
  		end

  		post "/create" do
  			@comment = CommentStuff.new(params).create
  			if @comment.persisted?
          { status: true, message: "Comment Created Successfully", comment_id: @comment.id}
        else
          { status: false, message: @comment.errors}
        end
   		end

   		desc "update a comment"
  		params do
  			requires :comment_id
  			use :comment_fields
  		end

  		post 'update' do
  			@comment = Comment.find_by(id: params[:comment_id])
  			@comment, result = CommentStuff.new(params).update(@comment) if @comment
        if result
          { status: true, message: "Comment Updated Successfully"}
        else
          { status: false, message: @comment.errors}
        end
  		end

  		desc "show a comment"
  		params do
  			requires :comment_id
  		end

  		get 'show', rabl: "comment_show" do
  			@comment = Comment.find_by(id: params[:comment_id])
  		end

  		# get 'comments', rabl: "all_comments" do
  		# 	@comments = Comment.all.page(params[:page]).per(20).order('created_at DESC')
  		# end

  		get 'current_user_comments', rabl: "all_comments" do
  			@comments = current_user.comments.page(params[:page]).per(20).order('created_at DESC')
  		end

  		desc 'delete a comment'
  		params do
  			requires :comment_id
  		end

  		delete "/delete" do
  			@comment = Comment.find_by(id: params[:comment_id])
  			if @comment.destroy
          { status: true, message: "Comment Deleted Successfully"}
        else
          { status: false, message: @comment.errors}
        end
  		end
  	end
  end
end