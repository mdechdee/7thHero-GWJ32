extends Node2D
class_name Gun

signal on_shoot
signal on_detach
signal bullet_shot(bullet)
var aimer: Node2D

export(int, 0 ,30) var MAX_AMMO: int = 20

func _notification(what):
	yield(self, "ready")
	match what:
		NOTIFICATION_PARENTED:
			print("equiped")
			owner.connect("on_attack", self, "shoot")
			owner.connect("on_drop_weapon", self, "detach")
		NOTIFICATION_UNPARENTED:
			print("unequiped")
			owner.disconnect("on_attack", self, "shoot")
			owner.disconnect("on_drop_weapon", self, "detach")
	
func _ready():
	aimer = find_parent("Aimer")
	if GlobalVar.DEBUG:
		$DebugLine1.show()
		$DebugLine2.show()
		$RadiusDebug.show()

puppet func shoot():
	emit_signal("on_shoot")

puppet func detach():
	emit_signal("on_detach")
	queue_free()
