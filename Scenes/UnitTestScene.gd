extends Node2D

func _ready():
	var network_id = get_tree().get_network_unique_id()
	var this_player: Node2D = $Player
	this_player.name = "Player" + var2str(network_id)
	this_player.set_network_master(network_id)
