extends Node
class_name UnitMovement

onready var body: KinematicBody2D = owner
export(float, 50, 100) var MOVE_SPEED
export(float, 2000, 3000) var DASH_SPEED

var move: Vector2
var is_dashing: bool = false
puppet var puppet_pos: Vector2
puppet var puppet_move: Vector2

func _physics_process(_delta):
	if !is_network_master():
		body.position = puppet_pos
		move = puppet_move
	else:
		if is_dashing:
			on_dash()
		else:
			on_move()
		rset_unreliable("puppet_move", move)
		rset_unreliable("puppet_pos", body.position)
	if !is_network_master():
		puppet_pos = body.position # To avoid jitter
	if GlobalVar.DEBUG:
		debug()

func do_move_input(dir: Vector2):
	if(is_dashing):
		return
	if(dir == Vector2.ZERO):
		move.x = lerp(move.x,0,0.2)
	move += dir * MOVE_SPEED

func do_aim(aim_at: Vector2):
	($"../HeadPosition" as Position2D).look_at(aim_at)
	
func do_dash(dir:Vector2):
	if is_dashing:
		return
	move = dir * DASH_SPEED
	is_dashing = true
	$DashTimer.start()

func on_move():
	move.y += GlobalVar.GRAVITY
	move.y = clamp(move.y, -GlobalVar.MAX_Y_SPEED, GlobalVar.MAX_Y_SPEED)
	move.x = clamp(move.x, -GlobalVar.MAX_X_SPEED, GlobalVar.MAX_X_SPEED)
	move = body.move_and_slide(move)
	if move.length() < 0.01:
		move = Vector2.ZERO
		
func on_dash():
	move = lerp(move, Vector2.ZERO, 0.2)
	move = body.move_and_slide(move)
	
func debug():
	$"../SpeedDebugger".text = "%.3f, %.3f" % [move.x,move.y]
	$"../Name".text = owner.name

func _on_DashTimer_timeout():
	is_dashing = false
