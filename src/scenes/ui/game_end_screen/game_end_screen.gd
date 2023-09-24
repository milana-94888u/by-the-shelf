extends Control


@export var start_scene: PackedScene


func _on_restart_button_pressed() -> void:
	RelationshipManager.relationship = 0.0
	get_tree().change_scene_to_packed(start_scene)
