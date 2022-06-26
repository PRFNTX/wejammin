extends KinematicBody2D
class_name Projectile

export(float) var direction = 1.2
export(float) var speed = 200.0

enum projectile_types {
	RED,
	GREEN,
}
export(projectile_types) var type = projectile_types.RED


func _physics_process(delta):
	var collision = move_and_collide(Vector2(cos(direction), sin(direction))*speed*delta)
	if collision != null:
		print(collision.collider.name)
		var name = collision.collider.name
		if collision.collider.has_method("hit_by_projectile"):
			collision.collider.call("hit_by_projectile", type)
			self.queue_free()
