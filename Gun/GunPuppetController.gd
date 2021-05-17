extends Node
export(NodePath) onready var shooter = get_node(shooter) as Shooter

func _ready():
	owner.connect("on_attach", self, "do_attach")
	owner.connect("on_detach", self, "do_detach")

func do_attach():
	if GlobalVar.IS_ONLINE:
		if owner.owner.is_network_master():
			owner.set_network_master(get_tree().get_network_unique_id())
			owner.connect("on_shoot", self, "do_spawn_bullet")

func do_spawn_bullet():
	shooter.rpc_unreliable("do_shoot")

