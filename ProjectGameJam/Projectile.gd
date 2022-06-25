extends KinematicBody2D

export(float) var direction = 1.2
export(float) var speed = 200.0

func _physics_process(delta):
	var collision = move_and_collide(Vector2(cos(direction), sin(direction))*speed*delta)
	if collision != null:
		collision.collider.queue_free()
