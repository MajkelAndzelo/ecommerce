class UsersController < ApplicationController
    before_action :require_login, only: [:edit, :update]
    before_action :require_admin, only: [:index, :destroy]
    before_action :set_user, only: [:edit, :update, :destroy]
    before_action :require_owner_or_admin, only: [:edit, :update, :destroy]
  
    def index
      @users = User.all
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path, notice: "You have successfully signed up"
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @user.update(user_params)
        redirect_to root_path, notice: "Your profile has been updated"
      else
        render :edit
      end
    end
  
    def destroy
      @user.destroy
      redirect_to users_path, notice: "User deleted successfully"
    end

    private
  
    def user_params
        params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :first_name)
    end
    def admin?
        role == "admin"
    end
    def set_user
      @user = User.find(params[:id])
    end
  
    def require_owner_or_admin
      unless current_user.admin? || current_user == @user
        redirect_to root_path, alert: "You are not authorized to perform this action"
      end
    end
end
  