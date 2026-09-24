extends Control

func _ready():
	$PlayButton.pressed.connect(Game.start_game)
