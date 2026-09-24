extends StaticBody2D

var player: Node2D

func _physics_process(_delta):
	if $CollisionShape2D.disabled and player:
		var d := (player.global_position - global_position).abs()
		if d.x >= 32 or d.y >= 64:
			$CollisionShape2D.set_deferred("disabled", false)
