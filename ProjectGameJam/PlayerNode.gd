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

func kill_and_respawn():
	get_parent().get_node("SpawnLocation").spawn_player()
	

func change_health(new_health_value):
	if new_health_value == 0:
		kill_and_respawn()
	else:
		current_health = new_health_value
		$Healthbar.value = new_health_value
		
func on_player_did_action():
	can_player_do_action = false
	current_action_points_value = initial_action_point_value

func do_player_action():
	on_player_did_action()

func charge_action_bar(new_action_points_value):
	current_action_points_value = new_action_points_value
	$ActionTimeBar.value = new_action_points_value
	if new_action_points_value == max_action_points_value:
		can_player_do_action = true
	

var start_rotation = rotation
func _physics_process(delta):
	var move_up = false
	var move_left = false
	var move_right = false
	var move_down = false
	if Input.is_action_pressed("move_up"):
		move_up = Input.is_action_pressed(("move_up"))
	if Input.is_action_pressed("move_down"):
		move_down = Input.is_action_pressed(("move_down"))
	if Input.is_action_pressed("move_left"):
		move_left = Input.is_action_pressed(("move_left"))
	if Input.is_action_pressed("move_right"):
		move_right = Input.is_action_pressed(("move_right"))
	var horizontal_speed = 0
	var vertical_speed = 0
	if move_up:
		vertical_speed -= 1
	if move_down:
		vertical_speed += 1
		
	if move_left:
		horizontal_speed -= 1
	if move_right:
		horizontal_speed += 1
		
	var initial_velocity = Vector2(
		horizontal_speed,
		vertical_speed
	).normalized()*player_speed
	var collision = move_and_slide(initial_velocity)
	
func got_charge_item():
	if current_action_points_value == max_action_points_value and can_player_do_action:
		pass
	else:
		charge_action_bar(current_action_points_value + 1)

func hit_by_projectile(type):
	if type == Projectile.projectile_types.RED:
		change_health(current_health - 1)
	elif type == Projectile.projectile_types.GREEN:
		if current_action_points_value == max_action_points_value and can_player_do_action:
			pass
		else:
			charge_action_bar(current_action_points_value + 1)
