extends State

var move: Vector2
var body: KinematicBody2D

func physics_process(delta):
	move = lerp(move, Vector2.ZERO, 0.2)
	move = body.move_and_slide(move)

func _on_DashTimer_timeout():
	get_parent().is_dashing = false
