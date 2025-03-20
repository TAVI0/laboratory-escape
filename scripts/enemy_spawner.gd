extends Node2D

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 5.0
	timer.one_shot = false
	timer.timeout.connect(spawn_enemy)
	add_child(timer)
	timer.start()

func spawn_enemy():
	var enemy_instance = preload("res://scanes/enemy.tscn").instantiate()
	enemy_instance.global_position = global_position
	get_parent().add_child(enemy_instance)
