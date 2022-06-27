extends Node2D

var player = preload("res://PlayerNode.tscn")

export (NodePath) var spawn_scene = null

func _ready():
	print("ready")
	spawn_player()

func spawn_player():
	var node = null
	if spawn_scene != null:
		node = get_node(spawn_scene)
	if node != null:
		var created_player = player.instance()
		#var existing_players = get_tree().get_nodes_in_group("player")
		#for old in existing_players:
		#	old.queue_free()
		#created_player.add_to_group("player")
		node.add_child(created_player)
		created_player.position = self.global_position
		created_player.get_node("Camera").current = true
		print(created_player.global_position)
