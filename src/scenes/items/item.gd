@tool
class_name Item
extends Area2D


@onready var sprite := $Sprite2D as Sprite2D
@onready var collision_shape := $CollisionShape2D as CollisionShape2D


@export var item_data: ItemData:
	set(new_item_data):
		item_data = new_item_data
		if not is_node_ready():
			await ready
		sprite.texture = item_data.item_texture
		collision_shape.shape = item_data.item_collision

@export var item_dialog: ItemDialog


func set_active() -> void:
	(material as ShaderMaterial).set_shader_parameter("enabled", true)


func remove_active() -> void:
	(material as ShaderMaterial).set_shader_parameter("enabled", false)


func interact() -> void:
	pass


#func _ready() -> void:
#	item_data = ItemData.new()
#	item_data.item_collision = collision_shape.shape
#	item_data.item_texture = sprite.texture
#	item_data.item_name = name


func _on_mouse_entered() -> void:
	ItemsSelectionManager.set_active_item(self)


func _on_mouse_exited() -> void:
	ItemsSelectionManager.remove_active_item(self)
