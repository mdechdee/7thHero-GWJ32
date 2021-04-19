extends Node

var input_log: Dictionary
onready var actions: Array = InputMap.get_actions()

func _ready():
	Input.set_use_accumulated_input(false)
	input_log["move_left"] = ActionHistory.new()

func _physics_process(delta):
	var mouse_pos = owner.get_global_mouse_position()
	var time = OS.get_ticks_msec()
	handle_horizontal()
	handle_dash(mouse_pos)
	handle_door()
	handle_aim(mouse_pos)
	handle_input_log(time)
	debug()

func handle_door():
	if Input.is_action_just_pressed("enter_door"):
		owner.emit_signal("on_enter_door")

func handle_input_log(time):
	for action in actions:
		if !input_log.has(action):
			continue
		if Input.is_action_just_pressed(action):
			var action_history = input_log[action] as ActionHistory
			action_history.current = true
			action_history.pressed_time.append(time)
			if(action_history.pressed_time.size() > 2):
				action_history.pressed_time.pop_front()
		elif Input.is_action_just_released(action):
			var action_history = input_log[action] as ActionHistory
			action_history.current = false
			action_history.released_time.append(time)
			if(action_history.released_time.size() > 2):
				action_history.released_time.pop_front()
			
func handle_aim(mouse_pos: Vector2):
	owner.emit_signal("on_aim", mouse_pos)
	if Input.is_action_pressed("attack"):
		owner.emit_signal("on_attack")
	
func handle_dash(mouse_pos: Vector2):
	if(Input.is_action_just_pressed("dash")):
		owner.emit_signal("on_dash", owner.global_position.direction_to(mouse_pos))
		
func handle_horizontal():
	if(Input.is_action_pressed("move_right")):
		owner.emit_signal("on_move", Vector2.RIGHT)
	if(Input.is_action_pressed("move_left")):
		owner.emit_signal("on_move", Vector2.LEFT)
	if(!Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right")):
		owner.emit_signal("on_move", Vector2.ZERO)

func debug():
	if GlobalVar.DEBUG:
		for action in input_log:
			var action_history = input_log[action] as ActionHistory
			$"../InputDebugger".text = action + "\n" + action_history.to_string()
