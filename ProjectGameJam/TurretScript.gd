tool
extends Node
class_name TurretScript

enum ACTIONS {
	DELAY=1,
	MOVE=2,
	ROTATE=3,
	SHOOT=4,
	RELOAD=5,
	CUSTOM=6,
}
export(ACTIONS) var action_type = ACTIONS.DELAY
export(int) var order = 0
# ALL
export var time = 0.1
# DELAY

# MOVE
var move_direction = null
var move_speed = null
 
# ROTATE
var rotate_radians = 0

# SHOOT/RELOAD
var projectile = preload("res://Projectile.tscn")
var projectile_speed = null
var projectile_direction = null
var projectile_type = null
var projectile_lifetime = null

# RELOAD
var bullet_pattern = null


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
			"hint": PROPERTY_HINT_FILE,
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
		{
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": "-6.28,6.28,0.1",
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "shoot/lifetime",
			"type": TYPE_REAL,
		},
	],
	ACTIONS.RELOAD: [
		{
			"hint": PROPERTY_HINT_FILE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "reload/projectile",
			"type": TYPE_STRING,
		},
		{
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "reload/projectile_speed",
			"type": TYPE_INT,
		},
		{
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": "-6.28,6.28",
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "reload/direction",
			"type": TYPE_REAL,
		},
		{
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": "GREEN,RED",
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "reload/type",
			"type": TYPE_INT,
		},
		{
			"hint": PROPERTY_HINT_RANGE,
			"hint_string": "-6.28,6.28,0.1",
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "reload/lifetime",
			"type": TYPE_REAL,
		},
		{
			"hint": PROPERTY_HINT_FILE,
			"usage": PROPERTY_USAGE_DEFAULT,
			"name": "reload/bullet_pattern",
			"type": TYPE_STRING,
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
		"shoot/projectile", "reload/projectile":
			return projectile
		"shoot/projectile_speed", "reload/speed":
			return projectile_speed
		"shoot/direction", "reload/direction":
			return projectile_direction
		"shoot/type", "reload/type":
			return projectile_type
		"shoot/lifetime", "reload/lifetime":
			return projectile_type
		"reload/bullet_pattern":
			return bullet_pattern

func _set(property, value):
	match property:
		"delay/time", "move/time", "rotate/time":
			time = value
			return true
		"move/direction":
			move_direction = value
			return true
		"move/speed":
			if value == 0:
				return true
			move_speed = value
			return true
		"rotate/radians":
			rotate_radians = value
			return true
		"shoot/projectile", "reload/projectile":
			projectile = value
			return true
		"shoot/projectile_speed", "reload/speed":
			if value == 0:
				return true
			projectile_speed = value
			return true
		"shoot/direction", "reload/direction":
			projectile_direction = value
			return true
		"shoot/type", "reload/type":
			projectile_type = value
			return true
		"shoot/lifetime", "reload/lifetime":
			projectile_type = value
			return true
		"reload/bullet_pattern":
			bullet_pattern = value
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
	if action_type == ACTIONS.DELAY:
		delay()
	if action_type == ACTIONS.MOVE:
		move()
	if action_type == ACTIONS.ROTATE:
		rotate()
	if action_type == ACTIONS.SHOOT:
		shoot()
	if action_type == ACTIONS.RELOAD:
		reload()
		

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
	delay_timer.connect("timeout", delay_timer, "queue_free")
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
	var init_speed = turret.projectile_speed
	var init_dir = turret.direction
	var init_type = turret.type
	if projectile_speed != null:
		turret.projectile_speed = projectile_speed
	if projectile_direction != null:
		turret.direction += projectile_direction
	if projectile_type != null:
		turret.type = projectile_type
	turret.fire_projectile(turret.time_passed)
	turret.projectile_speed = init_speed
	turret.direction = init_dir
	turret.type = init_type
	next()

func reload():
	if projectile_speed != null:
		turret.projectile_speed = projectile_speed
	if projectile_direction != null:
		turret.direction += projectile_direction
	if projectile_type != null:
		turret.type = projectile_type
	if projectile_lifetime != null:
		turret.projectile_lifetime = projectile_lifetime
	if projectile != null:
		turret.projectile = projectile
	#if bullet_pattern != null:
	#	turret.projectile = projectile
	next()
