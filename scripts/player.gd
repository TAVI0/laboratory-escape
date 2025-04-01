class_name Player extends CharacterBody2D

#@export var shot : PackedScene

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
