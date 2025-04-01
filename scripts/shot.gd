extends Area2D

var direction = Vector2.ZERO
@export var speed = 1000
@export var shot_scale = 1.0
@export var damage = 5

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func start(start_pos: Vector2, target_pos: Vector2):
	scale *= shot_scale
	position = start_pos  
	direction = (target_pos - start_pos).normalized() 
	rotation = direction.angle()
	
func _process(delta):
	#var sum = 1
	#sum += 0.05
	#scale *= sum
	global_position += direction * speed * delta  # Movemos el disparo
