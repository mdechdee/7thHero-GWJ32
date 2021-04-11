extends Node
class_name UnitMovement

onready var body: KinematicBody2D = owner
export(float, 50, 100) var MOVE_SPEED
export(float, 2000, 3000) var DASH_SPEED
var move: Vector2
var is_dashing: bool = false

func _physics_process(_delta):
	if is_dashing:
		on_dash()
		return
	on_move()
	if GlobalVar.DEBUG:
		debug()

func do_move_input(dir: Vector2):
	if(is_dashing):
		return
	if(dir == Vector2.ZERO):
		move.x = lerp(move.x,0,0.2)
	move += dir * MOVE_SPEED

func on_move():
	move.y += GlobalVar.GRAVITY
	move.y = clamp(move.y, -GlobalVar.MAX_Y_SPEED, GlobalVar.MAX_Y_SPEED)
	move.x = clamp(move.x, -GlobalVar.MAX_X_SPEED, GlobalVar.MAX_X_SPEED)
	move = body.move_and_slide(move)

func on_dash():
	move = lerp(move, Vector2.ZERO, 0.2)
	move = body.move_and_slide(move)

func do_dash(dir:Vector2):
	if is_dashing:
		return
	move = dir * DASH_SPEED
	is_dashing = true
	$DashTimer.start()
	
func debug():
	$"../SpeedDebugger".text = var2str(move)

func _on_DashTimer_timeout():
	is_dashing = false
