extends Polygon2D
tool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _ready():
	set_projectile_type()
	
func set_projectile_type():
	var parent = get_parent()
	if not "type" in parent:
		return
	var projectile_to_colour_type = {parent.projectile_types.RED: Color.red, parent.projectile_types.GREEN: Color.green}
	self.color = projectile_to_colour_type[parent.type]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
