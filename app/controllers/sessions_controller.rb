class SessionsController < ApplicationController
    before_action :require_login, except: [:new, :create]
  
    def new
    end
  
    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: "You have successfully logged in"
      else
        flash.now[:alert] = "Invalid email or password"
        render :new
      end
    end
  
    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: "You have been logged out"
    end
  
    private
  
    def require_login
      unless current_user || (params[:controller] == 'sessions' && params[:action] == 'new') || (params[:controller] == 'products' && params[:action] == 'index')
        redirect_to login_path
      end
    end
end
  