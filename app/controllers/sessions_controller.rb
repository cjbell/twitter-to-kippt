class SessionsController < ApplicationController
  
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
    
  def auth_kippt
    
  end
  
  def auth_kipt_postback
    if params[:kippt_username] && params[:kippt_password]
      # Try and auth with Kippt
      kippt = Kippt::Client.new(username: params[:kippt_username], password: params[:kippt_password]) 
      account = kippt.account rescue nil
      
      unless account.nil?
        current_user.update_kippt_details(account)
        redirect_to root_url, notice: "Kippt account authorised!"
        return
      end
    end
    
    render :action => "auth_kippt" 
  end
end
