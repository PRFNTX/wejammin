extends Node2D
class_name BasicTurret

export(float, -6.28, 6.28, 0.01) var direction = 0
export(float) var projectile_speed = 200.0
export(float, 0, 20, 0.1) var projectile_lifetime = 8
export(float) var fire_rate = 0.5
export(Projectile.projectile_types) var type = Projectile.projectile_types.RED
export(PackedScene) var projectile = null


export(NodePath) var scene_path
var scene
func _ready():
	if scene_path != null:
		scene = get_node(scene_path)
	if scene == null:
		scene = get_tree().current_scene

onready var children = get_children()
var patterns = null
func fire_projectile(time):
	if patterns == null:
		patterns = []
		if children != null && children.size() > 0:
			for child in children:
				if child is ProjectilePattern:
					child.load_pattern(self, scene)
					patterns.append(child)
	if patterns.size():
		for pattern in patterns:
			pattern.fire(time)
	else:
		var new_projectile = projectile.instance()
		scene.add_child(new_projectile)
		new_projectile.lifetime = projectile_lifetime
		new_projectile.init()
		new_projectile.direction = direction + rotation
		new_projectile.speed = projectile_speed
		new_projectile.position = global_position
		new_projectile.type = type

var reload = 0
var time_passed = 0
func _physics_process(delta):
	reload += delta
	time_passed += delta
	if reload > fire_rate:
		reload = 0
		fire_projectile(time_passed)
