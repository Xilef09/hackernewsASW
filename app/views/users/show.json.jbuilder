json.extract! @user, :id, :name, :created_at, :about, :email
json.hal user_url(@user)