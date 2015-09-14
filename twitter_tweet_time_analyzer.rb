#wrapper for twitter API
require 'twitter'
#gem for parsing date and time
require 'chronic'



#setting up client via api
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "XXXXXXXX"
  config.consumer_secret     = "XXXXXXXX"
  config.access_token        = "XXXXXXXX"
  config.access_token_secret = "XXXXXXXX"

#iterating through tweets by top pick

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {count: 200, include_rts: true}
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
  end
end


#find the time that they tweeted locally

#get tweets
data = client.get_all_tweets("BenSimmons25")

#timezone offset and print
data.each do |tweet|

   tweet_time = tweet.created_at

   time_zone_offset = tweet.user.utc_offset
   tweet_time = tweet_time + time_zone_offset  
   puts time_zone_offset
   puts tweet_time.strftime("%I:%M%p")
   puts "---"

end
