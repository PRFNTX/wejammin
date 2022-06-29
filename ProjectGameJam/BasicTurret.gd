extends Node2D
class_name BasicTurret

export(float, 0, 6.28, 0.1) var direction = 1.2
export(float) var projectile_speed = 200.0
export(float) var fire_rate = 0.5
export(Projectile.projectile_types) var type = Projectile.projectile_types.RED


onready var scene = get_tree().current_scene
func _ready():
	pass

export(PackedScene) var projectile = null
func fire_projectile():
	var new_projectile = projectile.instance()
	scene.add_child(new_projectile)
	new_projectile.type = type
	new_projectile.direction = direction + rotation
	new_projectile.speed = projectile_speed
	new_projectile.position = global_position


var reload = 0
func _physics_process(delta):
	reload += delta
	if reload > fire_rate:
		reload = 0
		fire_projectile()
