class_name damageUpgrade
extends Upgrade

@export var shot_damage := 2.0

func apply_upgrade(player: Player):
	player.damage += shot_damage
