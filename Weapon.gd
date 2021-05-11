extends Node2D
class_name Weapon

func _notification(what):
	yield(self, "ready")
	match what:
		NOTIFICATION_PARENTED:
			owner.connect("on_attack", self, "do_attack")
		NOTIFICATION_UNPARENTED:
			owner.disconnect("on_attack", self, "do_attack")

func do_attack():
	pass
