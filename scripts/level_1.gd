extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	$Label.set_text(str(GLOBAL.health))
	$oleada.set_text(str(GLOBAL.enemy_to_spawn))
	$damage.set_text(str($Player.damage))
	if(GLOBAL.wave_end):
		$UpgradeSpawner.spawn_upgrade()
		GLOBAL.wave_end=false
