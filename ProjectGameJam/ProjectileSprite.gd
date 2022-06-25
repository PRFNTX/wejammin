extends Polygon2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	if not "type" in parent:
		return
	var projectile_to_colour_type = {parent.projectile_types.RED: Color.red, parent.projectile_types.GREEN: Color.green}
	self.color = projectile_to_colour_type[parent.type]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
