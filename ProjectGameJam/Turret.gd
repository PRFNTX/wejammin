extends PathFollow2D

export(float) var direction = 1.2
export(float) var projectile_speed = 200.0
export(float) var fire_rate = 0.5
export(float) var move_speed = 100


onready var scene = get_tree().current_scene
func _ready():
	pass

export(PackedScene) var projectile = null
func fire_projectile():
	var new_projectile = projectile.instance()
	scene.add_child(new_projectile)
	
	new_projectile.direction = direction + rotation
	new_projectile.speed = projectile_speed
	new_projectile.position = global_position

func move_railcar(delta):
	offset += delta * move_speed

var reload = 0
func _physics_process(delta):
	reload += delta
	if reload > fire_rate:
		reload = 0
		fire_projectile()
	move_railcar(delta)
