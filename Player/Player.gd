extends KinematicBody2D

signal on_attack()
signal on_shot()

func _ready():
	if GlobalVar.DEBUG:
		$Name.show()
		$SpeedDebugger.show()
		$InputDebugger.show()
		$HpDebugger.show()

func set_team(team):
	$TeamController.team = team
