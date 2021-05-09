extends KinematicBody2D

signal on_move(move)
signal on_dash(dir)
signal on_aim(dir)

signal on_attack()
signal on_attack_just_pressed()
signal on_attack_just_released()

signal on_skill_q()
signal on_skill_q_just_pressed()
signal on_skill_q_just_released()
signal on_skill_e()
signal on_skill_e_just_pressed()
signal on_skill_e_just_released()

signal on_attacked()
signal on_kill(victim)
signal on_dead()

signal on_drop_weapon()
signal on_interact()

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
