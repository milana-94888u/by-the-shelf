class_name Item
extends Area2D


func set_active() -> void:
	(material as ShaderMaterial).set_shader_parameter("enabled", true)


func remove_active() -> void:
	(material as ShaderMaterial).set_shader_parameter("enabled", false)


func interact() -> void:
	pass


func _on_mouse_entered() -> void:
	ItemsSelectionManager.set_active_item(self)


func _on_mouse_exited() -> void:
	ItemsSelectionManager.remove_active_item(self)
