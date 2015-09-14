#wrapper for twitter API
require 'twitter'
# gem for scraping html
require 'nokogiri'
# gem for handling fetching html from internet
require 'open-uri'
#handle ccv files
require 'csv'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "XXXXXXXX"
  config.consumer_secret     = "XXXXXXXX"
  config.access_token        = "XXXXXXXX"
  config.access_token_secret = "XXXXXXXX"

#scrapes top recruits from nbadraft.net mock draft
def get_top_recurits
	#get the html
	doc = Nokogiri::HTML(open("http://www.nbadraft.net/2016mock_draft"))
	#get the table
	first_table = doc.css('table#nba_mock_consensus_table td')
	#make arrray of players
	player_array = Array.new
	
	(2..first_table.size).step(8) do |n|
		player_array.push(first_table[n].text)
	end

	second_table = doc.css('table#nba_mock_consensus_table2 td')

	(2..second_table.size).step(8) do |n|
		player_array.push(second_table[n].text)
	end
	return player_array

end

#accepts an array of player names as command line argument
def client.get_twitter_ids(player_names)
	player_twitter_id_array = Hash.new
	player_names.each do |player_name|
		search_results = user_search(player_name)
		if (search_results.empty? || search_results[0].followers_count < 750 || search_results[0].protected?)
			player_twitter_id_array[player_name] = nil
		else
			twitter_id = search_results[0].id
			player_twitter_id_array[player_name] = twitter_id

		end
	end
	return player_twitter_id_array
end

players = client.get_twitter_ids(get_top_recurits)

CSV.open("player_ids.csv", "wb") {|csv| players.to_a.each {|elem| csv << elem} }




