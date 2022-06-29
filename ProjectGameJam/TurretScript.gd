tool
extends Node
class_name TurretScript

enum ACTIONS {
	DELAY=1,
	MOVE=2,
	ROTATE=3,
	SHOOT=4,
	CUSTOM=5,
}
export(ACTIONS) var action_type = ACTIONS.DELAY
# ALL
var time = 0.1
# DELAY

# MOVE
var move_direction = null
var move_speed = null
 
# ROTATE
var rotate_radians = 0

# SHOOT
var projectile = preload("res://Projectile.tscn")
var projectile_speed = null
var projectile_direction = null
var projectile_type = null


var properties = {
	ACTIONS.DELAY: [],
	ACTIONS.MOVE: [
		{
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": "0,6.28",
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "move/direction",
			"type": TYPE_REAL,
		},
		{
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "move/speed",
			"type": TYPE_INT,
		},
		{
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "move/time",
			"type": TYPE_REAL,
		},
	],
	ACTIONS.ROTATE: [
		{
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": "-6.28,6.28",
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "rotate/radians",
			"type": TYPE_REAL,
		},
		{
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "rotate/time",
			"type": TYPE_REAL,
		},
	],
	ACTIONS.SHOOT: [
		{
			"hint": PROPERTY_HINT_RESOURCE_TYPE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "shoot/projectile",
			"type": TYPE_STRING,
		},
		{
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "shoot/projectile_speed",
			"type": TYPE_INT,
		},
		{
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": "-6.28,6.28",
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "shoot/direction",
			"type": TYPE_REAL,
		},
		{
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": "GREEN,RED",
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "shoot/type",
			"type": TYPE_INT,
		},
	],
	ACTIONS.CUSTOM: [],
}

func _get(property):
	match property:
		"delay/time", "move/time", "rotate/time":
			return time
		"move/direction":
			return move_direction
		"move/speed":
			return move_speed
		"rotate/radians":
			return rotate_radians
		"shoot/projectile":
			return projectile
		"shoot/projectile_speed":
			return projectile_speed
		"shoot/direction":
			return projectile_direction
		"shoot/type":
			return projectile_type

func _set(property, value):
	match property:
		"delay/time", "move/time", "rotate/time":
			time = value
			return true
		"move/direction":
			move_direction = value
			return true
		"move/speed":
			move_speed = value
			return true
		"rotate/radians":
			rotate_radians = value
			return true
		"shoot/projectile":
			projectile = value
			return true
		"shoot/projectile_speed":
			projectile_speed = value
			return true
		"shoot/direction":
			projectile_direction = value
			return true
		"shoot/type":
			projectile_type = value
			return true
		_:
			return false

func _get_property_list():
	return properties[action_type]

func _ready():
	pass

var turret = null
func init(in_turret):
	turret = in_turret

var timer = 0

func start():
	print(action_type)
	if action_type == ACTIONS.DELAY:
		delay()
	if action_type == ACTIONS.MOVE:
		move()
	if action_type == ACTIONS.ROTATE:
		rotate()
	if action_type == ACTIONS.SHOOT:
		shoot()

func next():
	set_process(false)
	turret.next()

func start_timer(time, on_timeout):
	var delay_timer = Timer.new()
	delay_timer.process_mode = 0
	delay_timer.one_shot = true
	add_child(delay_timer)
	delay_timer.start(time)
	delay_timer.connect("timeout", self, on_timeout)
	return delay_timer

func delay():
	start_timer(time, "delay_end")

func delay_end():
	next()

func move():
	if move_direction != null:
		turret.move_direction = move_direction
	if move_speed != null:
		turret.move_speed = move_speed
	print(move_direction, move_speed)
	start_timer(time, "move_end")

func move_end():
	turret.move_direction = 0
	turret.move_speed = 0
	next()
	
func rotate():
	turret.rotate_speed = rotate_radians / time
	start_timer(time, "rotate_end")

func rotate_end():
	turret.rotate_speed = 0
	next()

func shoot():
	turret.fire_projectile(turret.time_passed)
	next()
