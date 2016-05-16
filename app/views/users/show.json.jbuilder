json.extract! @user, :id, :name, :created_at, :karma, :about, :email
json.hal user_url(@user)
json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :puntos, :created_at, :user_id, :contribution_id
  json.hal comment_url(comment)