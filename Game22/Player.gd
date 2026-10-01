extends Area2D

signal hit
@export var speed: float = 400.0
var active: bool = false
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()

func _process(delta: float) -> void:
	if not active:
		return
	var velocity := Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	if velocity.length() > 0.0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	# Keep the courier inside the illustrated arena, clear of the fixed HUD.
	position = position.clamp(Vector2(24, 112), screen_size - Vector2(24, 104))
	if velocity.x != 0.0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0.0
	elif velocity.y != 0.0:
		$AnimatedSprite2D.animation = "up"

func start(pos: Vector2) -> void:
	position = pos
	active = true
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(_body: Node2D) -> void:
	if not active:
		return
	active = false
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
