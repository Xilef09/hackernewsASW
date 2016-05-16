json.extract! @user, :id, :name, :created_at, :karma, :about, :email
json.hal user_url(@user)