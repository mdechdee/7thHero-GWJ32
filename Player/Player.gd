extends KinematicBody2D

signal on_move(move)
signal on_dash(dir)
signal on_aim(dir)

signal on_attack()
signal on_attacked()

signal on_door_entered(door)
signal on_door_exited(door)
signal on_enter_door()

func _ready():
	if GlobalVar.DEBUG:
		$Name.show()
		$SpeedDebugger.show()
		$InputDebugger.show()
		$HpDebugger.show()

func set_team(team):
	$Team.team = team
