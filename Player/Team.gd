extends Node
class_name Team

export(GlobalVar.TEAM) var team = GlobalVar.TEAM.ONE
export(NodePath) onready var gun = get_node(gun) as Gun

func _ready():
	gun.connect("bullet_shot", self, "_set_bullet_team")
	set_player_team()
	
func set_player_team():
	match team:
		GlobalVar.TEAM.ONE:
			owner.collision_layer = 1
		GlobalVar.TEAM.TWO:
			owner.collision_layer = 2
		GlobalVar.TEAM.THREE:
			owner.collision_layer = 4
		GlobalVar.TEAM.FOUR:
			owner.collision_layer = 8
		GlobalVar.TEAM.NEUTRAL:
			owner.collision_layer = 16
	
func _set_bullet_team(bullet: Area2D):
	match team:
		GlobalVar.TEAM.ONE:
			bullet.collision_mask = 2 + 4 + 8 + 16
		GlobalVar.TEAM.TWO:
			bullet.collision_mask = 1 + 4 + 8 + 16
		GlobalVar.TEAM.THREE:
			bullet.collision_mask = 1 + 2 + 8 + 16
		GlobalVar.TEAM.FOUR:
			bullet.collision_mask = 1 + 2 + 4 + 16
		GlobalVar.TEAM.NEUTRAL:
			bullet.collision_mask = 1 + 2 + 4 + 8 + 16
	
