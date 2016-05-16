class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  def upvote
    
    if(current_user)
      @replies = Reply.find(params[:id])
      @replies.liked_by current_user
      @replies.update(puntos: @replies.votes_for.size)
      redirect_to "/contributions/#{@replies.contribution_id}"
    else 
      @replies = Reply.find(params[:id])
      myId = decodeToken(params[:user_token])
      @user =  User.find(myId)
      if(@user.voted_for? @replies)
         render :json => {:status => "403", :error => "El usuario ya ha votado este reply"}, status: :forbidden
      else 
        @replies.liked_by @user
        @replies.update(puntos: @replies.votes_for.size)
        
          render :json => {status => "200", :id => params[:id], :content => @replies.content, 
          :puntos => @replies.puntos ,:contribution_id => @replies.contribution_id , :user_id => @replies.user_id, :comment_id => @replies.comment_id,
          :created_at => @replies.created_at }
      end
    end
    
  end 
  
  def downvote
    @replies = Reply.find(params[:id])
    @replies.downvote_by current_user
    redirect_to :back
  end

  # GET /replies
  # GET /replies.json
  def index
    if (params[:comment_id] == nil )
      @replies = Reply.all
    else 
      @micomment = Comment.find(params[:comment_id])
      
      @replies = Reply.where(comment_id: params[:comment_id])
    end
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
    @repy = Reply.find(params[:id])
  end

  # GET /replies/new
  def new
    @reply = Reply.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  # POST /replies.json
  def create
    if(current_user)
      @reply = Reply.new(reply_params)
  
      respond_to do |format|
        if @reply.save
          format.html { redirect_to "/contributions/#{@reply.contribution_id}"}
          format.json { render :show, status: :created, location: @reply }
        else
          format.html { render :new }
          format.json { render json: @reply.errors, status: :unprocessable_entity }
        end
      end
    else
      miId = decodeToken(params[:user_token])
      @miuser = User.find(miId)
      @micontribution = Comment.find(params[:comment_id])
      
      params[:reply][:user_id] = miId
      params[:reply][:puntos] = 0
      @reply = Reply.new(reply_params)
      respond_to do |format|
        if @reply.save
          format.html { redirect_to "/contributions/#{@reply.contribution_id}"}
          format.json { render :show, status: :created, location: @reply }
        else
          format.html { render :new }
          format.json { render json: @reply.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @reply }
      else
        format.html { render :edit }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to replies_url, notice: 'Reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:content, :puntos, :user_id, :contribution_id, :comment_id)
    end
end
