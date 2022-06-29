extends BasicTurret


var move_direction = 0
var move_speed = 0

var rotate_speed = 0

var actions = []
var actionNumber = 0


func next():
	if (actions.size() > 0):
		actionNumber = (actionNumber + 1) % actions.size()
		actions[actionNumber].start()

func _ready():
	var children = get_children()
	for item in children:
		if item is TurretScript:
			actions.append(item)
	for action in actions:
		if action is TurretScript:
			action.call('init', self)
	actions.invert()
	next()

func _physics_process(delta):
	._physics_process(delta)
	position += Vector2(cos(move_direction), sin(move_direction))*move_speed*delta
	direction += rotate_speed * delta
	print(rotation, direction)
