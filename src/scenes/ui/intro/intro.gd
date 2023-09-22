extends Control


@onready var labels_row: Array[Label] = [
	$FirstLabel as Label, $SecondLabel as Label, $ThirdLabel as Label
]


@export var next_scene: PackedScene


var current_label := 0


func move_line() -> void:
	for label in labels_row:
		label.hide()
	if current_label < labels_row.size():
		labels_row[current_label].show()
	else:
		get_tree().change_scene_to_packed(next_scene)
	current_label += 1


func _ready() -> void:
	move_line()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		move_line()
