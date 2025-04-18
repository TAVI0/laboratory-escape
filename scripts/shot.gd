class_name Shot extends Area2D

var direction = Vector2.ZERO
var shot_speed: float
var shot_damage : int

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func start(start_pos: Vector2, target_pos: Vector2, shot_scale: float, speed: float, damage: int):
	shot_speed = speed
	shot_damage = damage
	direction = (target_pos - start_pos).normalized() 
	scale *= shot_scale
	position = start_pos  
	rotation = direction.angle()
	
func _process(delta):
	#var sum = 1
	#sum += 0.05
	#scale *= sum
	global_position += direction * shot_speed * delta  # Movemos el disparo
