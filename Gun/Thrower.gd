extends Node

export(float, 200, 500) var WEAPON_THROW_SPEED = 300
export(PackedScene) var pickable_scene
export(NodePath) onready var aimer = get_node(aimer) as Node2D
export(NodePath) onready var weapon_switcher = get_node(weapon_switcher) as Node

func _ready():
	if aimer == null:
		aimer = get_parent()
	owner.connect("on_drop_weapon", self, "do_throw_weapon")

func do_throw_weapon():
	var weapon: Node2D = weapon_switcher.current_weapon
	if weapon == null:
		return
		
	print("THROW")
	var pickable: Node2D = pickable_scene.instance()
	var dup_sprite = weapon.find_node("*Sprite*").duplicate(0)
	pickable.move = Vector2.RIGHT.rotated(aimer.rotation) * WEAPON_THROW_SPEED
	pickable.global_position = aimer.global_position
	pickable.add_child(dup_sprite)
	
	get_tree().current_scene.add_child(pickable)
