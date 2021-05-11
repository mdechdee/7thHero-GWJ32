extends Node

var current_weapon: Weapon
var weapons: Array = []

func _ready():
	for child in get_parent().get_children():
		print(child.name)
		if child.is_in_group("weapon"):
			weapons.push_back(child)
	current_weapon = weapons.front()
