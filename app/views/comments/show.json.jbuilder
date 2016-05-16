json.extract! @comment, :id, :content, :puntos, :user_id , :contribution_id, :created_at, :updated_at, :replies
json.array!( @comment.replies ) do |reply|
    json.url reply_url(reply, format: :json)
end