extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	#BUG
	var player = Player.new()
	var action_points = player.current_action_points_value
	print("player")
	if action_points < 5:
		print("not enough action points")
