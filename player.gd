extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
@export var max_echoes := 3

var echo_scene := preload("res://echo.tscn")
var echoes: Array = []

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

	if Input.is_action_just_pressed("freeze"):
		make_echo()
	if Input.is_action_just_pressed("restart") or global_position.y > 1200:
		get_tree().reload_current_scene()

func make_echo() -> void:
	var echo = echo_scene.instantiate()
	echo.player = self
	echo.position = position
	get_parent().add_child(echo)
	echoes.append(echo)
	if echoes.size() > max_echoes:
		echoes.pop_front().queue_free()
	Game.freeze_time()
