extends Area2D

func _ready():
	connect("body_entered", self, "_on_PickArea_body_entered")

func _on_PickArea_body_entered(body):
	pass
