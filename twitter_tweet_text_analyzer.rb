#wrapper for twitter API
require 'twitter'
#gem for counting words
require 'words_counted'
#handles csv files
require 'csv'

#setting up client via api
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "XXXXXXXX"
  config.consumer_secret     = "XXXXXXXX"
  config.access_token        = "XXXXXXXX"
  config.access_token_secret = "XXXXXXXX"
end

#iterating through tweets by top pick

def client.get_all_tweets(user)
  collect_with_max_id do |max_id|
    options = {count: 200, include_rts: false}
    options[:max_id] = max_id unless max_id.nil?
    user_timeline(user, options)
  end
end

word_count = String.new

data = client.get_all_tweets("BenSimmons25")

data.each do |tweet|
word_count = word_count + tweet.text
#  words = convert_to_word_array(tweet.text)
#  words.each do |word|
#    add_word_to_hash(word_count, word)  end
#end'
end

counter = WordsCounted.count(word_count)




