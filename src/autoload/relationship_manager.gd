extends Node


var remaining_items: Array[Item]


var good_ending := preload("res://src/scenes/ui/outro/good_outro.tscn")
var bad_ending := preload("res://src/scenes/ui/outro/bad_outro.tscn")


func register_item(item: Item) -> void:
	remaining_items.append(item)


func unregister_item(item: Item) -> void:
	remaining_items.erase(item)
	if remaining_items.is_empty():
		if relationship > 0:
			get_tree().change_scene_to_packed(good_ending)
		else:
			get_tree().change_scene_to_packed(bad_ending)


var relationship := 0.0
