json.extract! @comment, :id, :content, :puntos, :user_id , :contribution_id, :created_at, :updated_at, :replies
json.hal comment_url(@comment)