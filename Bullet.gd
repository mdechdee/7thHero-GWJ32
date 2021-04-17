extends Area2D

export(float,2,100) var BULLET_SPEED = 4

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * BULLET_SPEED

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
