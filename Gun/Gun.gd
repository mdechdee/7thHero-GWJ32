extends Weapon
class_name Gun
export(int, 0 ,30) var MAX_AMMO: int = 20

signal bullet_shot(bullet)
signal on_shoot

func _ready():
	if GlobalVar.DEBUG:
		$DebugLine1.show()
		$DebugLine2.show()
		$RadiusDebug.show()

puppet func do_attack():
	emit_signal("on_shoot")

func do_attach():
	.do_attach()
	if owner.has_node("Team"):
		var team = owner.get_node("Team") as Team	
		connect("bullet_shot", team, "set_bullet_team")
		
