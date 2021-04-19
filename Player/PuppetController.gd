extends Node

export(NodePath) onready var player_controller = get_node(player_controller) as Node
export(NodePath) onready var movement = get_node(movement) as Movement
onready var body: KinematicBody2D = owner

puppet var puppet_pos: Vector2
puppet var puppet_move: Vector2
puppet var puppet_rot: float

func _ready():
	set_physics_process(false)
	if GlobalVar.IS_ONLINE:
		print(owner.name + ": " + "is online")
		set_physics_process(true)
		if !owner.is_network_master():
			print(owner.name + ": " + "is puppet")
			player_controller.set_physics_process(false)
			movement.set_physics_process(false)

func _physics_process(delta):
	if !owner.is_network_master():
		body.position = puppet_pos
		movement.move = puppet_move
		body.get_node("HeadPosition").rotation = puppet_rot
		puppet_pos = body.position # To avoid jitter
	else:
		rset_unreliable("puppet_move", movement.move)
		rset_unreliable("puppet_pos", body.position)
		rset_unreliable("puppet_rot", body.get_node("HeadPosition").rotation)
