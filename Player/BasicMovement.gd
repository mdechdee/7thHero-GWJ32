extends State

export(float, 50, 100) var MOVE_SPEED = 50
var move: Vector2
var body: KinematicBody2D

func _ready():
	owner.connect("on_move", self, "do_move")
	is_on = true

func do_move(dir: Vector2):
	if(dir == Vector2.ZERO):
		move.x = lerp(move.x,0,0.2)
	move += dir * MOVE_SPEED
	print("MOVE ",dir)

func physics_process(delta):
	move.y += GlobalVar.GRAVITY
	move.y = clamp(move.y, -GlobalVar.MAX_Y_SPEED, GlobalVar.MAX_Y_SPEED)
	move.x = clamp(move.x, -GlobalVar.MAX_X_SPEED, GlobalVar.MAX_X_SPEED)
	move = owner.move_and_slide(move)
	if move.length() < 0.01:
		move = Vector2.ZERO
