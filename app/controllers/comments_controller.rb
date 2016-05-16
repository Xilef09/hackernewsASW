class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  
  def upvote
  
    if(current_user)
      @comments = Comment.find(params[:id])
      @comments.liked_by current_user
      @comments.update(puntos: @comments.votes_for.size)
      redirect_to "/contributions/#{@comments.contribution_id}"
    else 
      @comments = Comment.find(params[:id])
      myId = decodeToken(params[:user_token])
      @user =  User.find(myId)
      if(@user.voted_for? @comments)
         render :json => {:status => "403", :error => "El usuario ya ha votado este comment"}, status: :forbidden
      else 
        @comments.liked_by @user
        @comments.update(puntos: @comments.votes_for.size)
        
          render :json => {status => "200", :id => params[:id], :content => @comments.content, 
          :puntos => @comments.puntos ,:contribution_id => @comments.contribution_id , :user_id => @comments.user_id, 
          :created_at => @comments.created_at }
      end
    end 
    
  end  
  
  def downvote
    @comments = Comment.find(params[:id])
    @comments.downvote_by current_user
    redirect_to :back
  end

  # GET /comments
  # GET /comments.json
  def index
    if params[:contribution_id] == nil
      @comments = Comment.all
    else
      @contribution = Contribucion.find(params[:contribution_id])
      if @contribution == nil
         render :json => {:status => "404", :error => "No existe esta contribution"}, status: :forbidden
      else
        @comments = Comment.where(contribution_id: params[:contribution_id] )
      end
    end
      
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
    @replies = Reply.where(comment_id: params[:id])
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    if (current_user)
      @comment = Comment.new(comment_params)
      respond_to do |format|
        if @comment.save
          format.html { redirect_to "/contributions/#{@comment.contribution_id}" }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      params[:comment][:user_id] = decodeToken(params[:user_token])
      params[:comment][:puntos] = 0;
      @comment = Comment.new(comment_params)
      respond_to do |format|
        if @comment.save
          format.html { redirect_to "/contributions/#{@comment.contribution_id}" }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :puntos, :user_id, :contribution_id)
    end
end
