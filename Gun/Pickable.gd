extends KinematicBody2D
class_name WeaponPickable, "res://Icons/hand.svg"

var move: Vector2

func _ready():
	$PickArea.connect("body_entered", self, "_on_PickArea_body_entered")

func _on_PickArea_body_entered(body: Node):
	var aimer = body.find_node("Aimer") as Node
	if aimer == null:
		return
	for c in get_children():
		if !c.is_in_group("weapon"):
			continue
		var weapon = c as Weapon
		remove_child(weapon)
		aimer.add_child(weapon)
		queue_free()

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
