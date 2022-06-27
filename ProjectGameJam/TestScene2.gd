
extends Node2D

onready var scene_controller = get_tree().get_root().get_node("/root/SceneController")

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	scene_controller.change_scene(1)
