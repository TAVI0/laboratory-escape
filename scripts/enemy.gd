extends Node2D
const SPEED = 60
var healt = 5
var blink = false
func _ready() -> void:
	$AnimatedSprite2D.play()

func _process(delta: float) -> void:
	var direction = (GLOBAL.player_position - position).normalized()
	position += direction * SPEED * delta
	$AnimatedSprite2D.flip_h = (direction.x > 0)
	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("shot"):
		area.queue_free()
		_get_damage(area.damage)
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.queue_free()

func _get_damage(damage: int)->void:
	healt -= damage
	if healt<=0:
		queue_free()
	blink = true
	animation_blink()  # Inicia el parpadeo
	await get_tree().create_timer(0.3).timeout  # Espera el tiempo de invulnerabilidad
	blink = false
	
func animation_blink():
	while blink:
		$AnimatedSprite2D.visible = false  # Oculta el spriteS
		await get_tree().create_timer(0.05).timeout  # Espera 0.05 segundos
		$AnimatedSprite2D.visible = true  # Muestra el sprite
		await get_tree().create_timer(0.05).timeout  # Espera 0.05 segundos
