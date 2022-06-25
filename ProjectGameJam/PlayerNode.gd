extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var player_speed = 400

var move_up = false
var move_down = false
var move_left = false
var move_right = false


func _physics_process(delta):
	var horizontal_speed = 0
	var vertical_speed = 0
	if move_up:
		vertical_speed -= player_speed
	if move_down:
		vertical_speed += player_speed
		
	if move_left:
		horizontal_speed -= player_speed
	if move_right:
		horizontal_speed += player_speed
		
	var initial_velocity = Vector2(
		horizontal_speed,
		vertical_speed
	)
	print(initial_velocity)
	var collision = move_and_slide(initial_velocity)
	if collision != null:
		print(collision)
	

func _input(event):
	if event is InputEventKey:
		if event.is_action("move_up"):
			move_up = event.is_action_pressed(("move_up"))
			print(event);
			print("move up");
		elif event.is_action("move_down"):
			move_down = event.is_action_pressed(("move_down"))
			print(event);
			print("move down");
		elif event.is_action("move_left"):
			move_left = event.is_action_pressed(("move_left"))
			print(event);
			print("move left");
		elif event.is_action("move_right"):
			move_right = event.is_action_pressed(("move_right"))
			print(event);
			print("move right")
