extends State

var move: Vector2
var body: KinematicBody2D
export(float, 2000, 3000) var DASH_SPEED = 3000

func _ready():
	owner.connect("on_dash", self, "do_dash")

func do_dash(dir):
	$DashTimer.start()
	move = dir * DASH_SPEED
	is_on = true

func physics_process(delta):
	move = lerp(move, Vector2.ZERO, 0.2)
	move = owner.move_and_slide(move)

func _on_DashTimer_timeout():
	is_on = false
