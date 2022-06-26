extends Area2D
class_name Projectile

export(float) var direction = 1.2
export(float) var speed = 200.0


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

func _physics_process(delta):
	
	age += delta
	
	if age > life_time:
		self.queue_free()
	
	position += (Vector2(cos(direction), sin(direction))*speed*delta)

func _on_Projectile_body_entered(body):
	var name = body.name
	if body.has_method("hit_by_projectile"):
		body.call("hit_by_projectile", type)
	self.queue_free()

