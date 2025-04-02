class_name Enemy extends Node2D
const SPEED = 60
var healt = 5
var blink = false
var damage = 1
var player_contact:CharacterBody2D
var can_attack = true
func _ready() -> void:
	$AnimatedSprite2D.play()	

func _process(delta: float) -> void:
	if player_contact and can_attack:
		attack()
	var direction = (GLOBAL.player_position - position).normalized()
	position += direction * SPEED * delta
	if direction.x > 0:
		scale.x = -abs(scale.x)  # Asegura que siempre sea negativo
	else:
		scale.x = abs(scale.x)   # Asegura que siempre sea positivo
	#$AnimatedSprite2D.flip_h = (direction.x > 0)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("shot"):
		area.queue_free()
		_get_damage(area.damage)
		

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

func attack():
	if player_contact and can_attack:
		can_attack = false  # Bloquea nuevos ataques hasta que el temporizador termine
		player_contact._get_damage(damage)
		$AttackTimer.start(1)  # Inicia el temporizador

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_contact = body

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_contact = null


func _on_attack_timer_timeout() -> void:
	can_attack = true
