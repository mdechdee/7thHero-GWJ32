extends Node2D
class_name Gun

signal on_shoot
signal bullet_shot(bullet)

export(int, 0 ,30) var MAX_AMMO: int = 20

func _ready():
	owner.connect("on_attack", self, "shoot")
	if GlobalVar.DEBUG:
		$DebugLine1.show()
		$DebugLine2.show()
		$RadiusDebug.show()

puppet func shoot():
	emit_signal("on_shoot")

