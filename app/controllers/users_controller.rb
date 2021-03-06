class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :collection, only: %i[ index ]


  # GET /users or /users.json
  def index
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.role = 1
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "O funcionario foi criado com sucesso." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user.undiscard if params.dig(:restore)

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: "O funcionario foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    if @user.discarded?
      flash[:alert] = "Funcionario deletado previamente!"
    else
      flash[:notice] = "Funcionario deletado com sucesso!"
      @user.discard
    end

    redirect_to users_url
  end


  private
    # Set user list and @search object for the search form
    def collection
      @search = User.ransack(params[:q])
      @users = @search.result
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :role, :password, :password_confirmation)
    end
end
