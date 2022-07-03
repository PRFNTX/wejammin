extends Node2D


func _ready():
	pass

func _on_Area2D_body_entered(body):
	var name = body.name
	if body.has_method("got_charge_item"):
		body.call("got_charge_item")
	self.queue_free()
