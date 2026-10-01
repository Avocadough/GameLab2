@tool
extends StaticBody2D

@export var size := Vector2(280.0, 20.0):
	set(value):
		size = value
		if is_node_ready():
			_update_shape()

@export var accent := Color("57d2db"):
	set(value):
		accent = value
		queue_redraw()


func _ready() -> void:
	_update_shape()


func _update_shape() -> void:
	var rectangle := RectangleShape2D.new()
	rectangle.size = size
	$CollisionShape2D.shape = rectangle
	queue_redraw()


func _draw() -> void:
	var bounds := Rect2(-size * 0.5, size)
	draw_rect(bounds, Color("183647"))
	draw_rect(bounds, Color("2d5365"), false, 1.0)
	draw_line(Vector2(-size.x * 0.5 + 2.0, -size.y * 0.5 + 2.0),
		Vector2(size.x * 0.5 - 2.0, -size.y * 0.5 + 2.0), accent, 2.0)
	for x: float in [-size.x * 0.5 + 10.0, size.x * 0.5 - 10.0]:
		draw_circle(Vector2(x, 2.0), 2.0, Color("718795"))
