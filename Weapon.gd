extends Node2D
class_name Weapon
# extended by Gun

signal on_attach
signal on_detach

func _ready():
	connect("on_attach", self, "do_attach")
	connect("on_detach", self, "do_detach")

func do_attack():
	pass
	
func do_attach():
	print(name + " ATTACHED TO ",owner.name)
	owner.connect("on_attack", self, "do_attack")

func do_detach():
	print(name + " DETACHED FROM ", owner.name)
	#method_name signal_name source
	for connection in get_incoming_connections():
		if connection["source"] == self:
			continue
		connection["source"].disconnect(connection["signal_name"], self, connection["method_name"])
