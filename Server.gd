extends Node

func _ready():
	var network = NetworkedMultiplayerENet.new()
	network.create_server(4242,5)
	get_tree().set_network_peer(network)
