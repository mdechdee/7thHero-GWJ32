extends Area2D

func _ready():
	connect("body_entered", self, "_on_PickArea_body_entered")
	$EnableCollisionTimer.connect("timeout", self, "_on_EnableCollisionTimer_timeout")
	
func _on_PickArea_body_entered(body: Node):
	var aimer = body.find_node("Aimer") as Node
	if aimer == null:
		return
	for c in owner.get_children():
		if !c.is_in_group("weapon"):
			continue
		var weapon = c as Weapon
		owner.remove_child(weapon)
		aimer.add_child(weapon)
		owner.queue_free()

func _on_EnableCollisionTimer_timeout():
	monitoring = true
