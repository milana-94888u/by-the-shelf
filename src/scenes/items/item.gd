class_name Item
extends Area2D


@export var dialog_question: DialogQuestion

@export var item_texture: Texture2D:
	set(new_texture):
		item_texture = new_texture
		$Sprite2D.texture = item_texture


func set_active() -> void:
	(material as ShaderMaterial).set_shader_parameter("enabled", true)


func remove_active() -> void:
	(material as ShaderMaterial).set_shader_parameter("enabled", false)


func interact() -> void:
	pass


func _ready() -> void:
	$Sprite2D.texture = item_texture


func _on_mouse_entered() -> void:
	ItemsSelectionManager.set_active_item(self)


func _on_mouse_exited() -> void:
	ItemsSelectionManager.remove_active_item(self)
