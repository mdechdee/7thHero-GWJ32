extends Weapon
class_name Gun

signal bullet_shot(bullet)
signal on_shoot

export(int, 0 ,30) var MAX_AMMO: int = 20

func _ready():
	if GlobalVar.DEBUG:
		$DebugLine1.show()
		$DebugLine2.show()
		$RadiusDebug.show()

puppet func do_attack():
	emit_signal("on_shoot")

