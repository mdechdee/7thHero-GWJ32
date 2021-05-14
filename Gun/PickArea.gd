extends Area2D

func _ready():
	$EnableCollisionTimer.connect("timeout", self, "_on_EnableCollisionTimer_timeout")

func _on_EnableCollisionTimer_timeout():
	monitoring = true
