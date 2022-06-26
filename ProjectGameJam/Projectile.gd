extends Area2D
class_name Projectile

export(float) var direction = 1.2
export(float) var speed = 100

enum {
	ACTIVE,
	PASSIVE,
}
var mode = ACTIVE


var life_time = 8 #in seconds

enum projectile_types {
	RED,
	GREEN,
}
export(projectile_types) var type = projectile_types.RED setget set_projectile_type

func set_projectile_type(new_type):
	type = new_type
	$Sprite.set_projectile_type()

var age = 0

func hit_by_projectile(in_type):
	if in_type != type:
		set_passive()

func left_by_projectile(in_type):
	var reactivate = funcref(self, "set_active")
	create_tick_event(reactivate, 5)

func set_passive():
	$Sprite.color = Color.blue
	mode = PASSIVE

func set_active():
	set_projectile_type(type)
	mode = ACTIVE

var tick = 0
var tick_rate = 0.1
var del = 0
var tick_register = {}
func create_tick_event(on_fire, delta):
	var fire_time = tick + delta
	if tick_register.has(fire_time):
		tick_register[fire_time].append(on_fire)
	else:
		tick_register[fire_time] = [on_fire]
		
func fire_tick_events():
	if tick_register.has(tick):
		for event in tick_register[tick]:
			event.call_func()

func _physics_process(delta):
	del += delta
	if del > tick_rate:
		del = 0
		tick += 1
		fire_tick_events()
	age += delta
	if age > life_time:
		self.queue_free()
	
	position += (Vector2(cos(direction), sin(direction))*speed*delta)

func _on_Projectile_body_entered(body):
	var name = body.name
	if mode != PASSIVE:
		if body.has_method("hit_by_projectile"):
			body.call("hit_by_projectile", type)
		self.queue_free()


# hit projectile
func _on_Projectile_area_entered(area):
	if area.has_method("hit_by_projectile"):
		area.call("hit_by_projectile", type)


func _on_Projectile_area_exited(area):
	if area.has_method("left_by_projectile"):
		area.call("left_by_projectile", type)
