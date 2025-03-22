extends Area2D

var direction = Vector2.ZERO
const SPEED = 700

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func start(start_pos: Vector2, target_pos: Vector2):
	position = start_pos  # Posición inicial del disparo
	direction = (target_pos - start_pos).normalized()  # Direccionamos el disparo
	rotation = direction.angle()
	
func _process(delta):
	global_position += direction * SPEED * delta  # Movemos el disparo
