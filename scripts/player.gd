class_name Player extends CharacterBody2D

#@export var shot : PackedScene
var blink = false
const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
func _process(delta: float) -> void:
	GLOBAL.player_position = global_position

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var directiony := Input.get_axis("w", "s")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("click"):
		shoot_ctrl()

func shoot_ctrl() -> void:
	var shot_instance = preload("res://scanes/shot.tscn").instantiate() #shot.instantiate()
	shot_instance.start($Settings/ShootSpawn.global_position, get_global_mouse_position())
	get_parent().add_child(shot_instance)  # Agregamos el Shoot a la escena


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		pass
	#	_get_damage(body.damage)

func _get_damage(damage: int)->void:
	GLOBAL.health -= damage
	if GLOBAL.health <=0:
		queue_free()
	blink = true
	animation_blink()  # Inicia el parpadeo
	await get_tree().create_timer(0.4).timeout  # Espera el tiempo de invulnerabilidad
	blink = false
	
func animation_blink():
	while blink:
		$Sprite2D.visible = false  # Oculta el spriteS
		await get_tree().create_timer(0.05).timeout  # Espera 0.05 segundos
		$Sprite2D.visible = true  # Muestra el sprite
		await get_tree().create_timer(0.05).timeout  # Espera 0.05 segundos
