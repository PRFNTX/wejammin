extends ProjectilePattern


export(int) var speed = 200
export(int) var number = 6
export(Projectile.projectile_types) var type = Projectile.projectile_types.RED
#export(int) var move_rotation = TAU/8
#export(float) var lifetime = 3

func _ready():
	set_process(false)

func load_pattern(in_turret, bullet_scene):
	.load_pattern(in_turret, bullet_scene)
	print('loaded')

var fire_time = 0
func fire(time):
	projectile_properties = []
	for projectile_num in range(number):
		projectile_properties.append(
			Vector3(projectile_num*TAU/number, speed, int(type))
		)
	.fire(time)
