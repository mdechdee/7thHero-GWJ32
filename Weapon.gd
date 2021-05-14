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
	print("ATTACHED TO ",owner.name)
	owner.connect("on_attack", self, "do_attack")

func do_detach():
	print("DETACHED FROM ", owner.name)
	owner.disconnect("on_attack", self, "do_attack")
