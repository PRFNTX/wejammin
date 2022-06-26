extends KinematicBody2D
class_name Projectile

export(float) var direction = 1.2
export(float) var speed = 200.0


var life_time = 2 #in seconds

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
	
	var collision = move_and_collide(Vector2(cos(direction), sin(direction))*speed*delta)
	if collision != null:
		print(collision.collider.name)
		var name = collision.collider.name
		if collision.collider.has_method("hit_by_projectile"):
			collision.collider.call("hit_by_projectile", type)
			self.queue_free()
