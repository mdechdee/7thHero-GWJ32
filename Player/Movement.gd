extends Node
class_name Movement

onready var body: KinematicBody2D = owner
export(float, 50, 100) var MOVE_SPEED
export(float, 2000, 3000) var DASH_SPEED

var move: Vector2
var is_dashing: bool = false

func _ready():
	owner.connect("on_move", self, "do_move")
	owner.connect("on_dash", self, "do_dash")
	
func _physics_process(_delta):
	if is_dashing:
		on_dash()
	else:
		on_move()
	if GlobalVar.DEBUG:
		debug()

func do_move(dir: Vector2):
	if(is_dashing):
		return
	if(dir == Vector2.ZERO):
		move.x = lerp(move.x,0,0.2)
	move += dir * MOVE_SPEED
	
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
