extends BasicTurret


var move_direction = 0
var move_speed = 0

var rotate_speed = 0

var actions = []
var actionNumber = 0

func next():
	var delay_timer = Timer.new()
	delay_timer.process_mode = 0
	delay_timer.one_shot = true
	add_child(delay_timer)
	delay_timer.start(0.03)
	delay_timer.connect("timeout", self, "on_next", [delay_timer])
	return delay_timer

func on_next(delay_timer):
	delay_timer.queue_free()
	if (actions.size() > 0):
		actions[actionNumber].start()
		actionNumber = (actionNumber + 1) % actions.size()

func _ready():
	var children = get_children()
	for item in children:
		if item is TurretScript:
			actions.append(item)
	for action in actions:
		if action is TurretScript:
			action.call('init', self)
	actions.sort_custom(self, 'order_scripts') # by string -> name by id, hacky
	next()

func order_scripts(a, b):
	if a.order <= b.order:
		return true
	return false

func _physics_process(delta):
	._physics_process(delta)
	position += Vector2(cos(move_direction), sin(move_direction))*move_speed*delta
	direction += rotate_speed * delta
