extends Node
class_name Movement

var move: Vector2

func _physics_process(delta):
	for child in get_children():
		child = child as State
		if child.is_on:
			child.physics_process(delta)
			move = child.move # for debugging
			break
	
func debug():
	$"../SpeedDebugger".text = "%.3f, %.3f" % [move.x,move.y]
	$"../Name".text = owner.name
