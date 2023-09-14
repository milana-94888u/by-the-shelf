extends Node


var active_item: Item


func set_active_item(item: Item) -> void:
	if active_item == item:
		return
	if active_item:
		active_item.remove_active()
	active_item = item
	active_item.set_active()


func remove_active_item(item: Item) -> void:
	if active_item != item:
		return
	active_item.remove_active()
	active_item = null


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if active_item:
			active_item.interact()
