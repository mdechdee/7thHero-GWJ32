extends Node

export(float, 200, 500) var WEAPON_THROW_SPEED = 300
export(PackedScene) var pickable_scene
export(NodePath) onready var aimer = get_node(aimer) as Node2D

func _ready():
	if aimer == null:
		aimer = get_parent()
	owner.connect("on_drop_weapon", self, "do_throw_weapon")

func do_throw_weapon():
	var weapon: Weapon = aimer.current_weapon
	if weapon == null:
		return
	weapon.emit_signal("on_detach")
	weapon.get_parent().remove_child(weapon)
	weapon.position = Vector2.ZERO
	
	var pickable: Node2D = pickable_scene.instance()
	pickable.move = Vector2.RIGHT.rotated(aimer.rotation) * WEAPON_THROW_SPEED
	pickable.global_position = aimer.global_position
	pickable.add_child(weapon)
	get_tree().current_scene.add_child(pickable)
