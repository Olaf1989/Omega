class UsersController < ApplicationController
  # Voordat er inglogd is
  skip_before_action :require_login, only: [:show, :new, :create]
  # Nadat er inglogd is
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    authorize! :manage, User
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if current_user.has_role? :cursist or current_user.has_role? :teacher
      if  @user = current_user
        authorize! :update, User
      end

    elsif current_user.has_role? :admin
      authorize! :manage, User
    else
      render file: "#{Rails.root}/public/403.html", layout: true, status: 403
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if current_user.has_role? :cursist or current_user.has_role? :teacher
      if  @user = current_user
        authorize! :update, User
    end
    elsif current_user.has_role? :admin
      authorize! :manage, User
    else
      render file: "#{Rails.root}/public/403.html", layout: true, status: 403
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.add_role(:cursist)
    respond_to do |format|
      if @user.save
        format.html { redirect_to :home, notice: 'Gebruiker is succesvol aangemaakt.' }
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
    if current_user.has_role? :cursist or current_user.has_role? :teacher
      if  @user = current_user
        authorize! :update, User
      end
    elsif current_user.has_role? :admin
      authorize! :manage, User

      # Gebruikersrollen toggle, toggle_role begint vanaf regel 110
      @user = User.find(params[:id])
      toggle_role params[:role]
    else
      render file: "#{Rails.root}/public/403.html", layout: true, status: 403
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Gebruiker is succesvol gewijzigd.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if current_user.has_role? :cursist or current_user.has_role? :teacher
      if  @user = current_user
        authorize! :destroy, User
      end
    elsif current_user.has_role? :admin
      authorize! :manage, User
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :home, notice: 'Gebruiker is succesvol verwijderd.' }
      format.json { head :no_content }
    end
  end

  private

    # Gebruikersrollen toewijzing
    def toggle_role(role)
      if @user.has_role? role
        @user.remove_role role
      else
        @user.roles.destroy_all if @user.roles.any?
        @user.grant role
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :voornaam, :tussenvoegsel, :achternaam, :adres, :woonplaats, :telefoon, :role_ids)
    end
end
