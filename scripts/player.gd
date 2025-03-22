class_name Player extends CharacterBody2D

@export var shot : PackedScene

const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
func _process(delta: float) -> void:
	GLOBAL.player_position = global_position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
	var shot_instance = shot.instantiate()
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - position).normalized()

	shot_instance.rotation = (-mouse_pos).angle()
	shot_instance.start(position, mouse_pos)  # Llamamos a start() en la bala
	get_parent().add_child(shot_instance)  # Agregamos el Shoot a la escena
	#var shot_instance = shot.instantiate().start(position, mouse_pos)
	#shot_instance.global_position = $Settings/ShootSpawn.global_position
	#get_tree().call_group("Main", "add_child", shot_instance)
