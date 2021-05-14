extends Node2D

var current_weapon: Weapon = null
var weapons: Array = []

func _ready():
	owner.connect("on_aim", self, "do_aim")
	for child in get_children():
		if child.is_in_group("weapon"):
			weapons.push_back(child)
			owner.connect("on_attack", child, "do_attack")
	if weapons != []:
		current_weapon = weapons.front()

func add_child(child: Node, legible_unique_name: bool = false) -> void:
	.add_child(child,legible_unique_name)
	if !child.is_in_group("weapon"):
		return
	var weapon = child as Weapon
	weapon.owner = owner
	weapon.position += Vector2.RIGHT * 25
	weapon.emit_signal("on_attach")
	
	if weapons == []:
		current_weapon = weapon
	weapons.append(weapon)

puppet func do_aim(aim_at: Vector2):
	look_at(aim_at)
