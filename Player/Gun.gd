extends Node2D

export(PackedScene) var bullet_scene
export(float) var RATE_OF_FIRE: float = 10
export(float,0,90) var ACC_RADIUS: float = 0 
export(int, 0 ,30) var MAX_AMMO: int = 20

var acc_radius_penalty: float = 0
var shot_times: float = 0

func _ready():
	owner.connect("on_attack", self, "shoot")
	$BulletTimer.wait_time = 1/RATE_OF_FIRE
	if GlobalVar.DEBUG:
		$DebugLine1.show()
		$DebugLine2.show()

func _physics_process(delta):
	adjust_acc_penalty(delta)
	if GlobalVar.DEBUG:
		var total_acc_radius = ACC_RADIUS + acc_radius_penalty
		$DebugLine1.rotation_degrees = -total_acc_radius/2
		$DebugLine2.rotation_degrees = total_acc_radius/2
		$RadiusDebug.text = "Radius: " + var2str(total_acc_radius)

func adjust_acc_penalty(delta):
	if $RecoilTimer.is_stopped():
		shot_times -= delta*RATE_OF_FIRE*10
	shot_times = clamp(shot_times, 0, 90)
	acc_radius_penalty = atan(deg2rad(shot_times)) * 30

func shoot():
	if !$BulletTimer.is_stopped():
		return
	var bullet = bullet_scene.instance()
	var total_acc_radius = ACC_RADIUS + acc_radius_penalty
	bullet.global_position = global_position
	bullet.rotation = get_global_transform().get_rotation()
	bullet.rotation_degrees += randf() * total_acc_radius - total_acc_radius/2
	get_tree().current_scene.add_child(bullet)
	shot_times += 1
	$RecoilTimer.start()
	$BulletTimer.start()
