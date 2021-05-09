extends Node
class_name Movement

onready var body: KinematicBody2D = owner
export(float, 50, 100) var MOVE_SPEED
export(float, 2000, 3000) var DASH_SPEED

var move: Vector2
var states: Array  = []
var current_state: State

var is_dashing: bool = false

func _ready():
	owner.connect("on_move", self, "do_move")
	owner.connect("on_dash", self, "do_dash")
	for child in get_children():
		states.append(child)
	
func _physics_process(delta):
	current_state.physics_process(delta)
	
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

func debug():
	$"../SpeedDebugger".text = "%.3f, %.3f" % [move.x,move.y]
	$"../Name".text = owner.name
