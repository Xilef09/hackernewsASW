class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  
  def upvote
    @comments = Comment.find(params[:id])
    if(current_user)
      @comments.liked_by current_user
      @comments.update(puntos: @comments.votes_for.size)
    end 
    redirect_to "/contributions/#{@comments.contribution_id}"
  end  
  
  def downvote
    @comments = Comment.find(params[:id])
    @comments.downvote_by current_user
    redirect_to :back
  end

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
    if params[:contribution_id] != nil
      @commnets = Commnet.where(contribucion: params[:contribution_id]).order(created_at: :desc)
    end
      
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
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
