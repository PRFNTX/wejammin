extends Polygon2D
tool

var parent = null
func _ready():
	parent = get_parent()
	

func _process(delta):
	# rotate the arrow an amount equal to the angle between the default
	#diretion and the projectile direction
	self.rotation = parent.direction
	self.position = Vector2(cos(parent.direction), sin(parent.direction))*parent.projectile_lifetime*parent.projectile_speed
