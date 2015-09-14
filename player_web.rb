#builds graphs
require 'ruby-graphviz'
#hanldes reading csv files
require 'csv'

#make hash form key-value csv file
def make_hash(filename)
	player_id_csv = CSV.read(filename)
	player_ids_hash = Hash.new
	player_id_csv.each do |player|
		if (player[0] != nil)
			player_ids_hash[player[1]] = player[0]
		end
	end
	return player_ids_hash
end

# Create a new graph
player_graph = GraphViz.new( :G, :type => :digraph )

player_hash = make_hash("player_ids.csv")

#add player connections
CSV.foreach("player_connections.csv") do |row|
	player_graph.add_edges(player_hash[row[0]],player_hash[row[1]])
end

# Generate output image
player_graph.output( :png => "player_web.png" )

