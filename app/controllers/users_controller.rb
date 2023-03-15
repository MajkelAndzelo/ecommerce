class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update, :password_edit, :update_password]
  before_action :require_admin, only: [:index, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy, :password_edit, :update_password]
  before_action :correct_user, only: [:edit, :update, :destroy, :password_edit, :update_password]
  before_action :require_owner_or_admin, only: [:edit, :update, :destroy, :password_edit, :update_password]
  
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

    
    def update_password
      @user = User.find(params[:id])
      if @user.authenticate(params[:user][:old_password])
        if @user.update_with_password(update_password_params)
          redirect_to root_path, notice: "Your password has been updated"
        else
          flash.now[:alert] = "There was a problem updating your password: " + @user.errors.full_messages.join(", ")
          render :password_edit
        end
      else
        flash.now[:alert] = "Your old password is incorrect"
        render :password_edit
      end
    end
    
    
  
    def destroy
      @user.destroy
      redirect_to users_path, notice: "User deleted successfully"
    end

    private
  
    def password_edit
      @user = User.find(params[:id])
      require_owner_or_admin
    end

    def correct_user
      unless @user == current_user
        flash[:alert] = "You are not permitted to edit other users profiles"
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(:nickname,:first_name, :last_name, :email, :password, :password_confirmation)
    end
    
    def update_password_params
      params.require(:user).permit(:old_password, :new_password, :new_password_confirmation)
    end
    
    def admin?
        role == "admin"
    end
    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "You are not permitted to edit other users profiles"
      redirect_to root_path
    end
  
    def require_owner_or_admin
      unless current_user.admin? || current_user == @user
        redirect_to root_path, alert: "You are not authorized to perform this action"
      end
    end
end
  