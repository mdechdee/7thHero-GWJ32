extends Node

export(PackedScene) var pickable_scene

func _ready():
	owner.connect("on_detach", self, "do_detach")

func do_detach():
	var pickable: KinematicBody2D = pickable_scene.instance()
	var dup_sprite = $"../Sprite2D".duplicate(0)
	pickable.move = Vector2.UP * 10 
	pickable.global_position = owner.aimer.global_position
	pickable.add_child(dup_sprite)
	
	get_tree().current_scene.add_child(pickable)
	
	
