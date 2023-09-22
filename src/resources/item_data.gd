@tool
class_name ItemData
extends Resource


@export_category("Appearance")
@export var item_texture: Texture2D:
	set(new_texture):
		item_texture = new_texture
		emit_changed()
@export var item_closeup_texture: Texture2D
@export var item_collision: Shape2D:
	set(new_collision):
		item_collision = new_collision
		emit_changed()

@export_category("Description")
@export var item_name: String
@export var item_description: String
