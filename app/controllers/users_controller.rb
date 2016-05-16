class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :contributions]
  
  helper_method :getToken, :decodedToken

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    #@contributions = Contributions.all
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user  = User.find(params[:id])
    respond_to do |format|
      if params[:submission_type] == "contributions"
        @contributions = Contribution.where(user_id: @user.id).order(created_at: :desc)
        render 'showcontributions'
        #format.json { render :show, status: :ok, location: @contributions}
      elsif params[:submission_type] == "comments"
        @comments = Comment.where(user_id: @user.id).order(created_at: :desc)
        format.json {render :show, status: :ok, location: @comments}
      elsif params[:submission_type] == "replies"
        @replies = Reply.where(user_id: @user.id).order(created_at: :desc)
        format.json { render :show, status: :ok, location: @replies}
      else 
        format.json { render :show, status: :created, location: @user }
      end
    end
  end

  # GET /users/1/contributions
  def contributions
    @user = User.find(params[:id])
    @contributions = @user.contributions.paginate(page: params[:page])
  end
  

  # GET /login
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /loginP
  # POST /loginP.json
  def login
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    id = decodeToken(params[:user_token])
    if (@user.id == id)
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
       render :json => {:status => "403", :error => "No estas autorizado a editar el perfil"}, status: :forbidden
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def contributions
    @user  = User.find(params[:id])
    @contributions = Contribution.where(user_id: @user.id).order(created_at: :desc)
    render 'showcontribution'
  end
  
  def comments
    @user  = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id).order(created_at: :desc)
    render 'showcomments'
  end
  
  def replies
    @user  = User.find(params[:id])
    @replies = Reply.where(user_id: @user.id).order(created_at: :desc)
    render 'showreplies'
  end
  
  def edit
    @user  = User.find(params[:id])
    render 'edit'
    
  end
  
  def threads
    @user  = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id).order(created_at: :desc)
    @replies = Reply.where(user_id: @user.id).order(created_at: :desc)
    render 'showthreads'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :about, :karma)
    end
end
