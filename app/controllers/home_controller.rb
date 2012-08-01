class HomeController < ApplicationController
  
  before_filter :signed_in_user?, :only => [:delete_account, :change_kippt_list, :update_kippt_list]
  before_filter :kippt_auth?, :only => [:change_kippt_list, :update_kippt_list]
  
  def index
    
  end
  
  def delete_account
    current_user.delete_account
    session[:user_id] = nil
    redirect_to root_path, notice: "Your account has been deleted."
  end
  
  def change_kippt_list
    @lists = current_user.kippt.lists.all
  end
  
  def update_kippt_list
    if params[:user][:kippt_list_id]
      current_user.kippt_list_id = params[:user][:kippt_list_id]
      current_user.save
      redirect_to root_path, notice: "Kippt list updated"
    end
  end
  
  private 
  
  def signed_in_user?
    if current_user.nil?
      redirect_to root_path, notice: "Unauthorised"
      return
    end
  end
  
  def kippt_auth?
    if !current_user.kippt_authorized? 
      redirect_to root_path, notice: "Unauthorised"
      return
    end
  end
end
