if @posts.present?
  node do |u|
    {
      :status => true
    }
  end
  child @posts, :object_root => false do
    node do |u|
      {
        :id => u.id,
        :title => u.title,
        :body => u.body,
        :user_id => u.user_id
      }
    end

    child :mediums do
		  attributes :id, :attachment_file_name, :attachment_content_type, :attachment, :post_id
		end

		child :comments do
      node do |u|
        {
          :id => u.id,
          :body => u.body,
          :user_id => u.user_id,
          :post_id => u.post_id
        }
      end
		end

  end

else
  
  node do |u|
    {
      :status => false,
      :message => "No post available"
    }
  end
  
end