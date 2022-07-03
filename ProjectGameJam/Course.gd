extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var player = Player.new()
	var action_points = player.current_action_points_value
	var max_action_points = player.max_action_points_value
	if action_points < max_action_points:
		print("Timer over. Not enough action points. You Lose")
	else:
		print("Timer over. You got enough action points, you won!")
