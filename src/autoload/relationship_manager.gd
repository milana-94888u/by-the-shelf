extends Node


var remaining_items: Array[Item]


func register_item(item: Item) -> void:
	remaining_items.append(item)


func unregister_item(item: Item) -> void:
	remaining_items.erase(item)
	if remaining_items.is_empty():
		pass


var relationship := 0.0
