extends Node

export(int, 100, 200) var MAX_HP: int = 100
var current_hp: int 

func _ready():
	owner.connect("on_shot", self, "_on_shot")
	current_hp = MAX_HP
	print(current_hp)
	
func _on_shot():
	current_hp -= 10
	if GlobalVar.DEBUG:
		$"../HpDebugger".value = range_lerp(current_hp, 0, MAX_HP, 0, 100)
		print(range_lerp(current_hp, 0, MAX_HP, 0, 100))
