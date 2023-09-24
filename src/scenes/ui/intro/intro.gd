extends Control


@export var lines: Array[IntroDialogLine]
@export var next_scene: PackedScene

@onready var line_label := $LineLabel
@onready var said_by_label := $SaidByLabel

var current_line := 0


func move_line() -> void:
	if current_line < lines.size():
		line_label.text = lines[current_line].line_text
		said_by_label.text = lines[current_line].said_by
	else:
		get_tree().change_scene_to_packed(next_scene)
	current_line += 1


func _ready() -> void:
	move_line()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		move_line()
