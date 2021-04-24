extends Node

export(int, 100, 200) var MAX_HP: int = 100
var current_hp: int 

func _ready():
	owner.connect("on_attacked", self, "_on_attacked")
	current_hp = MAX_HP
	
func _on_attacked(dmg: DamageInstance):
	current_hp -= dmg.amount
	current_hp = clamp(current_hp, 0, MAX_HP)
	if(current_hp == 0):
		owner.emit_signal("on_dead", dmg.dealer)
		if dmg.dealer.has_signal("on_kill"):
			dmg.dealer.emit_signal("on_kill", owner)
		owner.queue_free()
	if GlobalVar.DEBUG:
		$"../HpDebugger".value = range_lerp(current_hp, 0, MAX_HP, 0, 100)
