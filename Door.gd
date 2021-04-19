extends Area2D
class_name Door

export(NodePath) onready var linked_door = get_node(linked_door) as Door 

func _on_Door_body_entered(body: Node):
	if body.has_signal("on_door_entered"):
		body.emit_signal("on_door_entered", self)
		
func _on_Door_body_exited(body: Node):
	if body.has_signal("on_door_exited"):
		body.emit_signal("on_door_exited", self)

