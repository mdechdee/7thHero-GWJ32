extends Area2D

export(float,2,100) var BULLET_SPEED = 4

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * BULLET_SPEED

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body: Node):
	if body.has_signal("on_shot"):
		body.emit_signal("on_shot")
	queue_free()
