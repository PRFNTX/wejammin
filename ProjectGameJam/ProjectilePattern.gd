extends Node
class_name ProjectilePattern

export(Array, Vector3) var projectile_properties = [
	Vector3(0, 200, 1)
] # direction offset, speed, type

export(PackedScene) var projectile = preload("res://Projectile.tscn")

func _ready():
	print(Projectile.projectile_types.RED)
	print(projectile_properties)

var turret = null
var scene = null
func load_pattern(in_turret, bullet_scene):
	turret = in_turret
	scene = bullet_scene

var created_projectiles = []
func fire(time):
	var base_direction = turret.direction
	for detail in projectile_properties:
		var new_projectile = projectile.instance()
		new_projectile.speed = int(detail.y)
		new_projectile.direction = detail.x + turret.direction
		new_projectile.type = round(detail.z)
		new_projectile.position = turret.global_position
		created_projectiles.append(new_projectile)
		scene.add_child(new_projectile)
