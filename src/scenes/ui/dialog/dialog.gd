class_name Dialog
extends Control


signal dialog_finished(is_item_taken: bool)


@onready var item_name_label := $HSplitContainer/ItemSide/VBoxContainer/ItemName as Label
@onready var item_texture_rect := $HSplitContainer/ItemSide/VBoxContainer/ItemTexture as TextureRect
@onready var item_description_label := $HSplitContainer/ItemSide/VBoxContainer/ItemDescription as Label


@onready var line_said_by := $HSplitContainer/DialogSide/DialogBox/DialogPanel/DialogLine/LineSaidBy as Label
@onready var line_text := $HSplitContainer/DialogSide/DialogBox/DialogPanel/DialogLine/LineText as Label

@onready var options_panel := $HSplitContainer/DialogSide/DialogBox/Options as VBoxContainer


var is_item_taken := false

var is_in_dialog := false


class DialogLinesRow extends RefCounted:
	var lines: Array[DialogLineBase]
	var current_index := 0

	func _init(dialog_lines: Array[DialogLineBase]) -> void:
		lines = dialog_lines
	
	func get_next_line() -> DialogLineBase:
		var result: DialogLineBase
		if current_index < lines.size():
			result = lines[current_index]
		current_index += 1
		return result


var dialog_stack: Array[DialogLinesRow]


func show_dialog(dialog: ItemDialog, item_data: ItemData) -> void:
	show()
	modulate = Color.WHITE
	dialog_stack.push_back(DialogLinesRow.new(dialog.lines))
	item_name_label.text = item_data.item_name
	if item_data.item_closeup_texture:
		item_texture_rect.texture = item_data.item_closeup_texture
	else:
		item_texture_rect.texture = item_data.item_texture
	item_description_label.text = item_data.item_description
	is_in_dialog = true
	move_line()


func get_next_line() -> DialogLineBase:
	if dialog_stack.size() == 0:
		return null
	var result := dialog_stack[-1].get_next_line()
	if result != null:
		return result
	while dialog_stack.size() > 1 and result == null:
		dialog_stack.pop_back()
		result = dialog_stack[-1].get_next_line()
	return result


func choose_option(option: DialogOption) -> void:
	RelationshipManager.relationship += option.relationship_change
	is_item_taken = is_item_taken or option.is_item_taken
	dialog_stack.push_back(DialogLinesRow.new(option.next_lines))
	move_line()


func add_option(option: DialogOption) -> void:
	var option_button := Button.new()
	option_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	option_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	option_button.text = option.option_text
	option_button.pressed.connect(choose_option.bind(option))
	options_panel.add_child(option_button)


func fill_options(options: Array[DialogOption]) -> void:
	for child in options_panel.get_children():
		options_panel.remove_child(child)
	for option in options:
		add_option(option)


func show_line(line: DialogLineBase) -> void:
	options_panel.hide()
	line_said_by.text = line.said_by
	line_text.text = line.line_text


func show_question(question: DialogQuestion) -> void:
	show_line(question)
	fill_options(question.options)
	options_panel.show()


func move_line() -> void:
	var next_line := get_next_line()
	if next_line == null:
		is_in_dialog = false
		dialog_finished.emit(is_item_taken)
		return
	if next_line is DialogQuestion:
		show_question(next_line)
	else:
		show_line(next_line)


func _input(event: InputEvent) -> void:
	if not is_in_dialog:
		return
	if event.is_action_pressed("ui_accept"):
		if not options_panel.visible:
			move_line()
