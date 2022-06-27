extends Node

var levels = [
	preload("res://TestScene.tscn"),
	preload("res://TestScene2.tscn"),
]

func change_scene(index):
	var new_scene = levels[index].instance()
	get_tree().get_root().add_child(new_scene)
