class HomeController < ApplicationController
  
  def index
    
  end
  
  def delete_account
    if !current_user.nil?
      current_user.delete_account
      session[:user_id] = nil
      redirect_to root_path, notice: "Your account has been deleted."
    else
      redirect_to root_path
    end
  end
  
end
