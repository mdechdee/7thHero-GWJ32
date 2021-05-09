extends Node

export(PackedScene) var bullet_scene
export(float) var RATE_OF_FIRE: float = 10
var dmg_instance: DamageInstance = DamageInstance.new()

func _ready():
	var aimer = find_parent("Aimer")
	if aimer == null:
		return
	owner.connect("on_shoot", self, "do_shoot")
	$BulletTimer.wait_time = 1/RATE_OF_FIRE
	
func do_shoot():
	if !$BulletTimer.is_stopped():
		return
	gen_bullet()
	$BulletTimer.start()
	if GlobalVar.IS_ONLINE and is_network_master():
		rpc_unreliable("gen_bullet")

puppet func gen_bullet():
	dmg_instance.amount = 10
	dmg_instance.dealer = find_parent("Player*")
	
	var bullet = bullet_scene.instance()
	bullet.global_position = owner.global_position
	bullet.rotation = owner.get_global_transform().get_rotation()
	bullet.dmg = dmg_instance
	get_tree().current_scene.add_child(bullet)
	owner.emit_signal("bullet_shot", bullet)
