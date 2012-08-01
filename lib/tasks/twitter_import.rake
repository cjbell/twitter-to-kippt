namespace :ttk do

  desc 'Imports all users favourites to Kippt'
  task :import_to_kippt => :environment do
    
    User.authorised.each do |user|
    
      twitter = user.twitter
      kippt = user.kippt
      
      p twitter.to_json
      
      tweets = twitter.favorites(:since_id => user.last_tweet.to_i, :count => 25, :include_entities => true)
      
      p "Got #{ tweets.length } tweets. Last tweet_id = #{ user.last_tweet }"
      
      last_id = user.last_tweet
      tweets.reverse.each do |tweet|
        # Get each URL in this tweet
        hashtags = tweet.hashtags.map(&:text).join(', ')
        
        tweet.expanded_urls.each do |url|
          # Add this to the users Kippt
          p "Adding a clip: "
          
          clip = kippt.clips.build
          clip.list = user.kippt_list_id
          clip.url = url
          clip.notes = "#{ tweet.text } - #{ tweet.user.name }"
          clip.save
          
          p "Clip saved: #{ clip }"
        end
        
        last_id = tweet.id
      end
      
      user.last_tweet_id = last_id
      user.time_of_last_sync = Time.now
      user.save
    end
    
  end
  
end