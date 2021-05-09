extends Node2D

func _ready():
	owner.connect("on_aim", self, "do_aim")

puppet func do_aim(aim_at: Vector2):
	look_at(aim_at)
