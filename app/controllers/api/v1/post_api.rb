module API::V1
  class PostAPI < Base

  	helpers do 
      params :post_fields do
      	requires :post, type: Hash do
      		requires :title, type: String
	  			requires :body, type: String
	  			requires :user_id, type: Integer
	  			optional :mediums_attributes, type: Array do
	          requires :attachment, :type => Rack::Multipart::UploadedFile
	        end
      	end
      end
    end

  	namespace :post do

  		desc "create a post"
  		params do
  			use :post_fields
  		end

  		post "create" do
  			@post = PostStuff.new(params).create
  			if @post.persisted?
          { status: true, message: "Post Created Successfully", post_id: @post.id}
        else
          { status: false, message: @post.errors}
        end
  		end


  		desc "update a post"
  		params do
  			requires :post_id
  			use :post_fields
  		end

  		post 'update' do
  			@post = Post.find_by(id: params[:post_id])
  			@post, result = PostStuff.new(params).update(@post) if @post
        if result
          { status: true, message: "Post Updated Successfully"}
        else
          { status: false, message: @post.errors}
        end
  		end

  		desc "show a post"
  		params do
  			requires :post_id
  		end

  		get 'show', rabl: "post_show" do
  			@post = Post.find_by(id: params[:post_id])
  		end

  		get 'posts', rabl: "all_post" do
  			@posts = Post.all.page(params[:page]).per(20).order('created_at DESC')
  		end

  		get 'current_user_posts' do
  			# @posts = current_user.posts.page(params[:page]).per(20).order('created_at DESC')
  			current_user.name
  		end

  		desc 'delete a post'
  		params do
  			requires :post_id
  		end

  		delete "/delete" do
  			@post = Post.find_by(id: params[:post_id])
  			if @post.destroy
          { status: true, message: "Post Deleted Successfully"}
        else
          { status: false, message: @post.errors}
        end
  		end

  	end
  end
end