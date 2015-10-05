if @comments.present?
  node do |u|
    {
      :status => true
    }
  end
  child @comments, :object_root => false do
    node do |u|
      {
        :id => u.id,
        :body => u.body,
        :user_id => u.user_id,
        :post_id => u.post_id
      }
    end

    child :mediums do
		  attributes :id, :attachment_file_name, :attachment_content_type, :attachment, :post_id
		end

		child :post do
		  attributes :id, :title, :body, :user_id
		end

  end

else
  
  node do |u|
    {
      :status => false,
      :message => "No comment available"
    }
  end
  
end