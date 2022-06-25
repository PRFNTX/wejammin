extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	
	if event is InputEventKey:
		if event.is_action("move_up"):
			print(event);
			print("move up");
		elif event.is_action("move_down"):
			print(event);
			print("move down");
		elif event.is_action("move_left"):
			print(event);
			print("move left");
		elif event.is_action("move_right"):
			print(event);
			print("move right")


func _on_Player_area_entered(area):
	pass # Replace with function body.
