extends Node2D

func spawn_upgrade():
	var upgrade = preload("res://scanes/item_upgrade.tscn").instantiate()
	upgrade.upgrade_resource = preload("res://resource/DamageUpgrade.tres")
	upgrade.global_position = global_position
	get_parent().add_child(upgrade)	
	pass
