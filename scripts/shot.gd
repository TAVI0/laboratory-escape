extends Area2D

const SPEED = 296

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

var direction = Vector2.ZERO

func start(start_pos: Vector2, target_pos: Vector2):
	position = start_pos  # Posición inicial del disparo
	direction = (target_pos - start_pos).normalized()  # Direccionamos el disparo

func _process(delta):
	global_position += direction * SPEED * delta  # Movemos el disparo
