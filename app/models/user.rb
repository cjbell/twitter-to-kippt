class User < ActiveRecord::Base
  attr_accessible :kippt_token, :kippt_username, :last_tweet_id, :twitter_token, :twitter_secret, :twitter_uid, :twitter_username, :twitter_avatar, :time_of_last_sync, :kippt_list_id
  
  scope :authorised, lambda { where("kippt_token IS NOT NULL AND kippt_username IS NOT NULL AND twitter_token IS NOT NULL AND twitter_secret IS NOT NULL") }
  
  def self.from_omniauth(auth)
    user = where(:twitter_uid => auth["uid"]).first
    
    if !user.nil?
      p auth.to_json
      
      user.twitter_token = auth["credentials"]["token"]
      user.twitter_secret = auth["credentials"]["secret"]
      user.save
      
      return user
    end
    
    create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.twitter_uid = auth["uid"]
      user.twitter_username = auth["info"]["nickname"]
      user.twitter_avatar = auth["info"]["image"]
      user.twitter_token = auth["credentials"]["token"]
      user.twitter_secret = auth["credentials"]["secret"]
    end
  end
  
  def kippt_authorized?
    (!self.kippt_username.blank? && !self.kippt_token.blank?)
  end  
  
  def update_kippt_details(account)
    self.kippt_username = account.username
    self.kippt_token = account.token
    self.save
  end
  
  def twitter
    Twitter.configure do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
      config.oauth_token = self.twitter_token
      config.oauth_token_secret = self.twitter_secret
    end
    Twitter::Client.new
  end
  
  def kippt
    Kippt::Client.new(username: self.kippt_username, token: self.kippt_token)
  end
  
  def last_tweet
    self.last_tweet_id.nil? ? 100 : self.last_tweet_id
  end
  
  def last_sync
    return self.time_of_last_sync.strftime("%D %R") unless self.time_of_last_sync.nil?
    return "N/A" if self.time_of_last_sync.nil?
  end
  
  def current_kippt_list
    if !self.kippt_list_id.nil?
      list = self.kippt.lists[self.kippt_list_id]
      return list.title unless list.nil? 
    end
    return "Inbox"  
  end
  
  def delete_account
    self.kippt_username = nil
    self.kippt_token = nil
    self.twitter_token = nil
    self.twitter_secret = nil
    self.save
  end
end
