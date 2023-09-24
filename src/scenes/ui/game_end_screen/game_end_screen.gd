extends Control


@export var start_scene: PackedScene


func _ready() -> void:
	if RelationshipManager.relationship > 0:
		$VBoxContainer/Label.text = "You managed the changes well.\nYou still talk frequently and are good friends."
	else:
		$VBoxContainer/Label.text = "You managed the changes poorly.\nYou still talk sometimes, but it feels like something changed."


func _on_restart_button_pressed() -> void:
	RelationshipManager.relationship = 0.0
	get_tree().change_scene_to_packed(start_scene)
