class ContributionsController < ApplicationController
    before_action :set_contribution, only: [:show, :edit, :update, :destroy]

  def upvote
          @contributions = Contribution.find(params[:id])

    if(current_user)
      @contributions.liked_by current_user
      @contributions.update(puntos: @contributions.votes_for.size)
    end
    redirect_to root_path
  end
  
  #def upvote 
  #  @contributions = Contribution.find(params[:id])
  #  @contributions.upvote_by current_user
  #  redirect_to :back
  #end
  
  def downvote
    @contributions = Contribution.find(params[:id])
    @contributions.downvote_by current_user
    redirect_to :back
  end

  # GET /contributions
  # GET /contributions.json
  def index
    if params[:contribution_type] == "show"
      @contributions = Contribution.where.not(url: '').order(created_at: :desc)
    elsif params[:contribution_type] == "ask"
      @contributions  = Contribution.where.not(content: '').order(created_at: :desc)
    elsif params[:contribution_type] == nil || params[:contribution_type] == ''
      @contributions  = Contribution.all.order(created_at: :desc)
    else
     render :json => {:status => "400", :error => "Bad Request"}, status: :bad_request
    end
  end
  
  # GET /contributions/users/1
  # GET /contributions/users/1.json
  def threads
    @threads = Contribution.where("user_id=?",params[:id]).all.order("created_at desc")
  end

  # GET /contributions/1
  # GET /contributions/1.json
  def show
    @comment = Comment.new
  end

  # GET /contributions/new
  def new
    @contribution = Contribution.new
  end

  # GET /contributions/1/edit
  def edit
  end

  # POST /contributions
  # POST /contributions.json
  def create
    @contribution = Contribution.new(contribution_params)

    respond_to do |format|
      if @contribution.save
        format.html { redirect_to "" }
        format.json { render :index, status: :created, location: @contribution }
      else
        format.html { render :new }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contributions/1
  # PATCH/PUT /contributions/1.json
  def update
    respond_to do |format|
      if @contribution.update(contribution_params)
        format.html { redirect_to @contribution, notice: 'Contribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribution }
      else
        format.html { render :edit }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributions/1
  # DELETE /contributions/1.json
  def destroy
    @contribution.destroy
    respond_to do |format|
      format.html { redirect_to contributions_url, notice: 'Contribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution
      @contribution = Contribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribution_params
      params.require(:contribution).permit(:titulo, :url, :puntos, :text, :tipo, :user_id)
    end
end
