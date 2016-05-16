json.extract! @user, :id, :name, :created_at, :karma, :about, :email, :comments
json.hal user_url(@user)