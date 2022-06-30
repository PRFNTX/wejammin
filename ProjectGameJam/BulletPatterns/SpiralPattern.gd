extends ProjectilePattern

export(int) var speed = 200
export(int) var rotation_rate = 6.28/8
export(Projectile.projectile_types) var type = Projectile.projectile_types.RED


func _ready():
	set_process(false)

func load_pattern(in_turret, bullet_scene):
	.load_pattern(in_turret, bullet_scene)

var fire_time = 0
var intervals = 0
func fire(time):
	var use_direction = (time * rotation_rate) - (intervals * TAU)
	while use_direction > TAU:
		intervals += 1
		use_direction -= TAU
	projectile_properties = [Vector3(
		use_direction, speed, type
	)]
	.fire(time)
