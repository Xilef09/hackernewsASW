class StaticPagesController < ApplicationController
     helper_method :getAuthor
  
  
  def home
    if params[:submission_type] == "show"
      #@contributions = Contribution.where.not(url: '').order(created_at: :desc)
    elsif params[:submission_type] == "ask"
      #@contributions = Contribution.where.not(content: '').order(created_at: :desc)
    else
      #@contributions = Contribution.all.order(created_at: :desc)
    end
  end
  
  def getAuthor(user_id)
    @user = User.find(user_id)
    author = @user.name
    return author    
  end
end
