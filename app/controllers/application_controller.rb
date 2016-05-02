class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :exception
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def getAuthor(user_id)
    @user = User.find(user_id)
    author = @user.name
    return author    
  end
  
  helper_method :getAuthor
  helper_method :current_user
end
