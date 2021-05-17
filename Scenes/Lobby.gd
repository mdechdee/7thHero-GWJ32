extends Node2D
var player_count = 1

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

func _player_connected(id):
	GlobalVar.other_player_id = id
	GlobalVar.IS_ONLINE = true
	get_tree().change_scene("res://Scenes/MultiplayerTestScene.tscn")
	
func _on_packet_recieved(id, packet):
	$Label.text = packet.get_string_from_ascii()

func _on_HostButton_pressed():
	var network = NetworkedMultiplayerENet.new()
	network.create_server(4242,2)
	get_tree().set_network_peer(network)
	$HostButton.disabled = true
	$JoinButton.hide()
	
func _on_JoinButton_pressed():
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 4242)
	get_tree().set_network_peer(network)
	$HostButton.hide()
	$JoinButton.disabled = true
