class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def after_sign_in_path_for(current_user)
    if current_user.role == "admin"
      return admin_root_path
    else
      return root_path
    end
  end
end
