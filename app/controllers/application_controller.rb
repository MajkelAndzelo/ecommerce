class ApplicationController < ActionController::Base
    helper_method :current_cart
    helper_method :current_user, :logged_in?
    before_action :require_login
    protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?, :require_admin


  def current_cart
    if logged_in?
      current_user.cart ||= Cart.create(user_id: current_user.id)
    else
      Cart.new
    end
  end


  private

  def require_login
    unless current_user || (params[:controller] == 'products' && params[:action] == 'index') || (params[:controller] == 'categories' && params[:action] == 'index')
      redirect_to login_path
    end
  end  
  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access this page"
    end
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def logged_in?
    current_user != nil
  end
end
