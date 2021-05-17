extends Control


func _on_Single_pressed():
	OS.execute("godot", ["res://Scenes/UnitTestScene.tscn"])

func _on_Multi_pressed():
	OS.execute("godot", [
			"res://Scenes/Lobby.tscn",
			"--resolution", "760x520",
			"--position", "0,0",
			"-t"], false)
	get_tree().change_scene("res://Scenes/Lobby.tscn")
	OS.window_position = Vector2(760,0)
	OS.window_size = Vector2(760, 520)
	OS.set_window_always_on_top(true)
