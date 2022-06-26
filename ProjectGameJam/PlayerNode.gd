extends KinematicBody2D

var player_speed = 400

var move_up = false
var move_down = false
var move_left = false
var move_right = false

var max_health = 5
var current_health = 5 setget change_health

var max_action_points_value = 5
var current_action_points_value = 0
var initial_action_point_value = 0
var can_player_do_action = false


func _ready():
	
	$Healthbar.max_value = max_health
	$Healthbar.value = current_health
	
	$ActionTimeBar.max_value = max_action_points_value
	$ActionTimeBar.value = current_action_points_value
	
func change_health(new_health_value):
	if new_health_value == 0:
		self.queue_free()
	else:
		current_health = new_health_value
		$Healthbar.value = new_health_value
		
func on_player_did_action():
	print("did action, yo")
	can_player_do_action = false
	current_action_points_value = initial_action_point_value

func do_player_action():
	on_player_did_action()

func charge_action_bar(new_action_points_value):
	current_action_points_value = new_action_points_value
	$ActionTimeBar.value = new_action_points_value
	if new_action_points_value == max_action_points_value:
		can_player_do_action = true
	

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
	var collision = move_and_collide(initial_velocity * delta)
	if collision != null:
		pass
	
func hit_by_projectile(type):
	if type == Projectile.projectile_types.RED:
		change_health(current_health - 1)
	elif type == Projectile.projectile_types.GREEN:
		if current_action_points_value == max_action_points_value and can_player_do_action:
			pass
		else:
			charge_action_bar(current_action_points_value + 1)
	
func _input(event):
	if event is InputEventKey:
		if event.is_action("move_up"):
			move_up = event.is_action_pressed(("move_up"))
		elif event.is_action("move_down"):
			move_down = event.is_action_pressed(("move_down"))
		elif event.is_action("move_left"):
			move_left = event.is_action_pressed(("move_left"))
		elif event.is_action("move_right"):
			move_right = event.is_action_pressed(("move_right"))
