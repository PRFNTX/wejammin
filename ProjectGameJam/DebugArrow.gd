extends Polygon2D
tool

var parent = null
func _ready():
	parent = self.get_parent()

func _process(delta):
	# rotate the arrow an amount equal to the angle between the default
	#diretion and the projectile direction
	self.rotation = parent.direction - PI/2
