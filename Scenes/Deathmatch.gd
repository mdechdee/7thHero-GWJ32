extends Node

var team_score: Dictionary = {}

func _ready():
	for node in get_tree().current_scene.get_children():
		if node.has_signal("on_dead"):
			node.connect("on_dead", self, "_on_dead", [node])
			node.connect("on_kill", self, "_on_kill", [node])
			if node.has_node("Team"):
				var team_node: Team = node.get_node("Team")
				team_score[team_node.team] = 0

func _process(delta):
	$Score.text = ""
	for team in team_score:
		$Score.text += ("TEAM " + GlobalVar.TEAM.keys()[team] + ": " +
				var2str(team_score[team]) + 
				"\n"
		)

func _on_dead(killer: Node, victim: Node):
	print(victim.name + " is dead.")
	if killer.has_node("Team"):
		var team_node: Team = killer.get_node("Team")
		team_score[team_node.team] += 1
		
func _on_kill(victim: Node, killer: Node):
	print(killer.name + " kills " + victim.name)
