extends Node2D

export(PackedScene) var player_scene

func _ready():
	var network_id = get_tree().get_network_unique_id()
	var this_player: Node2D = player_scene.instance()
	add_child(this_player)
	this_player.name = "Player" + var2str(network_id)
	this_player.set_network_master(network_id)
	if network_id < GlobalVar.other_player_id:
		this_player.position = $PlayerSpawn1.position
	else:
		this_player.position = $PlayerSpawn2.position
	
	var other_player: Node2D = player_scene.instance()
	add_child(other_player)
	other_player.name = "Player" + var2str(GlobalVar.other_player_id)
	other_player.set_network_master(GlobalVar.other_player_id)
	if GlobalVar.other_player_id < network_id:
		other_player.position = $PlayerSpawn1.position
	else:
		other_player.position = $PlayerSpawn2.position
