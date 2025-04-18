extends Area2D

@export var upgrade_resource: Upgrade

func _ready() -> void:
	$Label.text = upgrade_resource.name
	$Sprite2D.texture = upgrade_resource.texture

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		upgrade_resource.apply_upgrade(body)
		GLOBAL.enemy_to_spawn = 5
		queue_free()
