extends Node

export(float,0,90) var ACC_RADIUS: float = 0 
export(bool) var RECOIL_ENABLED: bool = true
export(bool) var ACC_ENABLED: bool = true

var acc_radius_penalty: float = 0
var shot_times: float = 0

func _ready():
	owner.connect("bullet_shot", self, "adjust_bullet")
	if RECOIL_ENABLED:
		owner.connect("on_shoot", self, "do_recoil")
	if !ACC_ENABLED:
		ACC_RADIUS = 0

func _physics_process(delta):
	if RECOIL_ENABLED:
		adjust_acc_penalty(delta)
	if GlobalVar.DEBUG:
		var total_acc_radius = ACC_RADIUS + acc_radius_penalty
		if $"../DebugLine1" != null:
			$"../DebugLine1".rotation_degrees = -total_acc_radius/2
			$"../DebugLine2".rotation_degrees = total_acc_radius/2
			$"../RadiusDebug".text = "Radius: " + var2str(total_acc_radius)
		
func do_recoil():
	shot_times += 1	
	$RecoilTimer.start()

func adjust_acc_penalty(delta):
	if $RecoilTimer.is_stopped():
		shot_times -= delta * 10
	shot_times = clamp(shot_times, 0, 90)
	acc_radius_penalty = atan(deg2rad(shot_times)) * 30

func adjust_bullet(bullet: Area2D):
	var total_acc_radius = ACC_RADIUS + acc_radius_penalty
	bullet.rotation_degrees += randf() * total_acc_radius - total_acc_radius/2
