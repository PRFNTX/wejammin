extends Node2D

var next_scene = preload("res://TestScene2.tscn")

func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	get_tree().change_scene_to(next_scene)
