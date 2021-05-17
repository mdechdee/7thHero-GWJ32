extends Weapon
class_name ChargeGun, "res://Icons/gun_icon.svg"

export(int, 0 ,30) var MAX_AMMO: int = 20
export(float, 10 ,100) var MAX_CHARGE: float = 100
export(float, 1 ,30) var CHARGE_RATE: float = 30
export(float, 1, 5) var MAX_BULLET_SCALE: float = 3

var is_charging: bool = false
var charge: float = 0

signal bullet_shot(bullet)
signal on_shoot

func _ready():
	self.connect("bullet_shot", self, "set_bullet_size")
	if GlobalVar.DEBUG:
		$ChargeDebug.show()
	
func set_bullet_size(bullet: Node2D):
	bullet.scale = Vector2.ONE * (charge / MAX_CHARGE) * MAX_BULLET_SCALE

func _process(delta):
	if is_charging:
		charge = min(charge + delta * CHARGE_RATE, MAX_CHARGE)
	$ChargeDebug.text = "charge: " + var2str(charge)
		
func do_start_charge():
	is_charging = true

func do_attack():
	emit_signal("on_shoot")
	charge = 0
	is_charging = false

func do_attach():
	owner.connect("on_attack_just_pressed", self, "do_start_charge")
	owner.connect("on_attack_just_released", self, "do_attack")
	if !owner.has_node("Team"):
		return
	var team = owner.get_node("Team") as Team	
	connect("bullet_shot", team, "set_bullet_team")
