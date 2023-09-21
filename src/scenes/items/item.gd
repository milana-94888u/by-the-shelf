@tool
class_name Item
extends Area2D


@onready var sprite := $Sprite2D as Sprite2D
@onready var collision_shape := $CollisionShape2D as CollisionShape2D

@onready var dialog := $DialogLayer/Dialog as Dialog


@export var item_data: ItemData:
	set(new_item_data):
		item_data = new_item_data
		if not is_node_ready():
			await ready
		sprite.texture = item_data.item_texture
		collision_shape.shape = item_data.item_collision

@export var item_dialog: ItemDialog


func _enter_tree() -> void:
	if not Engine.is_editor_hint():
		RelationshipManager.register_item(self)


func set_active() -> void:
	(material as ShaderMaterial).set_shader_parameter("enabled", true)


func remove_active() -> void:
	(material as ShaderMaterial).set_shader_parameter("enabled", false)


func interact() -> void:
	dialog.show_dialog(item_dialog, item_data)


func _on_mouse_entered() -> void:
	ItemsSelectionManager.set_active_item(self)


func _on_mouse_exited() -> void:
	ItemsSelectionManager.remove_active_item(self)


func _on_dialog_dialog_finished(is_item_taken: bool) -> void:
	collision_shape.disabled = true
	sprite.visible = not is_item_taken
	ItemsSelectionManager.remove_active_item(self)
	RelationshipManager.unregister_item(self)
	dialog.hide()
