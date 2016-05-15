class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def getAuthor(user_id)
    @user = User.find(user_id)
    author = @user.name
    return author    
  end
  
  def decodeToken ( myToken )
    require "base64"
    id  = Base64.decode64(myToken)
    return id.to_i
  end 
  
  helper_method :decodeToken
  helper_method :getAuthor
  helper_method :current_user
end
