namespace :ttk do

  desc 'Imports all users favourites to Kippt'
  task :import_to_kippt => :environment do
    
    User.authorised.each do |user|
      
      user.twitter
      kippt = user.kippt
      tweets = Twitter.favorites(:since_id => user.last_tweet, :count => 25, :include_entities => true)
      
      last_id = user.last_tweet
      tweets.each do |tweet|
        # Get each URL in this tweet
        hashtags = tweet.hashtags.map(&:text).join(', ')
        
        tweet.expanded_urls.each do |url|
          # Add this to the users Kippt
          clip = kippt.clips.build
          clip.url = url
          clip.notes = "#{ tweet.text } - #{ tweet.user.name }"
          clip.save
        end
        
        last_id = tweet.id
      end
      
      user.last_tweet_id = last_id
      user.time_of_last_sync = Time.now
      user.save
    end
    
  end
  
end