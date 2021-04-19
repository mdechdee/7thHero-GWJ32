extends Node

var door: Area2D = null

func _ready():
	owner.connect("on_door_entered", self, "_on_door_entered")
	owner.connect("on_door_exited", self, "_on_door_exited")
	owner.connect("on_enter_door", self, "do_enter_door")

func _on_door_entered(door: Area2D):
	self.door = door

func _on_door_exited(door:Area2D):
	self.door = null

func do_enter_door():
	if door != null:
		owner.global_position = door.linked_door.global_position

