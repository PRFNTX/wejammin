extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	#BUG
	var action_points = get_node("PlayerNode").get("current_action_points_value")
	print("player")
	if action_points < 5:
		print("not enough action points")
