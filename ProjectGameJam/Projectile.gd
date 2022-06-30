extends Node2D
class_name Projectile

export(float) var direction = 1.2
export(float) var speed = 100

var LAYER_RED = 1
var LAYER_GREEN = 2
var LAYER_PLAYER = 4
var LAYER_TERRAIN = 8

enum {
	ACTIVE,
	PASSIVE,
	INACTIVE,
}
var mode = INACTIVE

var projectile
var passifier
var sprite

var lifetime = 12 #in seconds

enum projectile_types {
	RED,
	GREEN,
}
export(projectile_types) var type = projectile_types.RED setget set_projectile_type

func set_projectile_type(new_type):
	type = new_type
	#if type == projectile_types.RED:
	#	projectile.set_collision_layer_bit(LAYER_RED, true)
	#	# TODO bleigghh or just don't make the bullet collision larger
	#	#passifier.set_collision_mask_bit(LAYER_RED, true)
	#if type == projectile_types.GREEN:
	#	pass
	#	projectile.set_collision_layer_bit(LAYER_GREEN, true)
	#	passifier.set_collision_mask_bit(LAYER_RED, true)
	$Sprite.set_projectile_type()

var age = 0

func hit_by_projectile(in_type):
	if in_type != type:
		set_passive()
	start_timer(1, "set_active")

#func left_by_projectile(in_type):
	#var reactivate = funcref(self, "set_active")
	#start_timer(1, "set_active")

func set_passive():
	sprite.color = Color.blue
	mode = PASSIVE
	#if type == projectile_types.RED:
	#	projectile.set_collision_layer_bit(LAYER_RED, false)
	#	#$passifier.set_collision_mask_bit(LAYER_RED, false)
	#if type == projectile_types.GREEN:
	#	projectile.set_collision_layer_bit(LAYER_GREEN, false)
	#	passifier.set_collision_mask_bit(LAYER_RED, false)

func set_active():
	set_projectile_type(type)
	mode = ACTIVE


func start_timer(time, on_timeout):
	var delay_timer = Timer.new()
	delay_timer.process_mode = 0
	delay_timer.one_shot = true
	add_child(delay_timer)
	delay_timer.start(time)
	delay_timer.connect("timeout", self, on_timeout)
	delay_timer.connect("timeout", delay_timer, "queue_free")
	return delay_timer

func _ready():
	start_timer(speed/800, "set_active")
	projectile = $Projectile
	passifier = $passifier
	sprite = $Sprite


func init():
	start_timer(lifetime, "queue_free")
	projectile = $Projectile
	passifier = $passifier
	sprite = $Sprite

func _physics_process(delta):
	position += (Vector2(cos(direction), sin(direction))*speed*delta)

func _on_Projectile_body_entered(body):
	var name = body.name
	print(name, mode)
	if mode != PASSIVE:
		if body.has_method("hit_by_projectile"):
			body.call("hit_by_projectile", type)
		self.queue_free()


func _on_passifier_area_entered(area):
	if mode != INACTIVE && area.has_method("hit_by_projectile"):
		area.call("hit_by_projectile", type)

#func _on_passifier_area_exited(area):
	#if area.has_method("left_by_projectile"):
	#	area.call("left_by_projectile", type)

func _on_Projectile_area_entered(area):
	if mode != INACTIVE && area.get_parent().has_method("hit_by_projectile"):
		area.get_parent().call("hit_by_projectile", type)
		hit_by_projectile((area.get_parent().type))
