#wrapper for twitter API
require 'twitter'
#handles csv files
require 'csv'

#setting up client via api
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "XXXXXXXX"
  config.consumer_secret     = "XXXXXXXX"
  config.access_token        = "XXXXXXXX"
  config.access_token_secret = "XXXXXXXX"
end
#make hash form key-value csv file
def make_hash(filename)
	player_id_csv = CSV.read(filename)
	player_ids_hash = Hash.new
	player_id_csv.each do |player|
		if (player[1] != nil)
			player_ids_hash[player[0]] = player[1].to_i
		end
	end
	return player_ids_hash
end

#returns array of frineds that are top recruits
def client.connections_with_recruits(player, player_hash)
	friends = friend_ids(player).to_a
	players = player_hash.values

	connections = friends & players
	puts connections
	return connections
end


player_hash = make_hash("player_ids.csv")


#write connections to csv file

player_ids = player_hash.values

player_ids.each do |player_id|
connections = client.connections_with_recruits(player_id.to_i ,player_hash)
CSV.open("player_connections.csv", "a") do |csv|
	connections.each do |connection|
		csv << [player_id, connection]
	end
end
	sleep(60)

end


