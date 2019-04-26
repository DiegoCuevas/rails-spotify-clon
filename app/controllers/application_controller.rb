class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authentication, :authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pundit

  def after_sign_in_path_for(current_user)
    if current_user.role == "admin"
      return admin_root_path
    else
      return root_path
    end
  end

  def user_not_authorized
    flash[:alert] = "You don't have access to this resource"
    redirect_to "/"
  end

  def authentication
    unless current_user
      unless devise_controller?
        flash[:notice] = "You must login to access to this page or to do this action"
        redirect_to "/"
      end
    end
  end

  def authorization
    unless devise_controller?
      if current_user
        authorize current_user, policy_class: AdminPolicy 
      else
        user_not_authorized
      end
    end
  end
end
