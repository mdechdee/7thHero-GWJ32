extends Node

export(NodePath) onready var unit = get_node(unit) as UnitMovement 

func _ready():
	assert(unit != null, "UnitMovement node is not assigned")

func _physics_process(delta):
	handle_horizontal()
	handle_special_movement()
	
func handle_special_movement():
	var mouse_pos = unit.body.get_global_mouse_position()
	if(Input.is_action_just_pressed("dash")):
		unit.do_dash(unit.body.global_position.direction_to(mouse_pos))
		
func handle_horizontal():
	if(Input.is_action_pressed("move_right")):
		unit.do_move_input(Vector2.RIGHT) 
	if(Input.is_action_pressed("move_left")):
		unit.do_move_input(Vector2.LEFT)
	if(!Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right")):
		unit.do_move_input(Vector2.ZERO)
