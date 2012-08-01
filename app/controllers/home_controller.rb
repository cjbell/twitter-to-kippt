class HomeController < ApplicationController
  
  before_filter :signed_in_user, :only => [:delete_account, :change_kippt_list]
  
  def index
    
  end
  
  def delete_account
    current_user.delete_account
    session[:user_id] = nil
    redirect_to root_path, notice: "Your account has been deleted."
  end
  
  def change_kippt_list
    
  end
  
  private 
  
  def signed_in_user
    if current_user.nil?
      redirect_to root_path
      return
    end
  end
end
