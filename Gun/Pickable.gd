extends KinematicBody2D

var move: Vector2

func _physics_process(delta):
	on_move()
	if is_on_floor():
		move = Vector2.ZERO
	
func on_move():
	move.y += GlobalVar.GRAVITY
	move.y = clamp(move.y, -GlobalVar.MAX_Y_SPEED, GlobalVar.MAX_Y_SPEED)
	move.x = clamp(move.x, -GlobalVar.MAX_X_SPEED, GlobalVar.MAX_X_SPEED)
	move = move_and_slide(move, Vector2.UP)
	if move.length() < 0.01:
		move = Vector2.ZERO
