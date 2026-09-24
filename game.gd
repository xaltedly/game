extends CanvasLayer

const LEVELS = [
	"res://level_1.tscn",
	"res://level_2.tscn",
	"res://level_3.tscn",
	"res://level_4.tscn",
	"res://level_5.tscn",
]

var fade := ColorRect.new()
var busy := false

func _ready():
	layer = 100
	process_mode = Node.PROCESS_MODE_ALWAYS
	fade.color = Color.BLACK
	fade.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade.modulate.a = 0.0
	add_child(fade)

func go_to(path: String) -> void:
	if busy:
		return
	busy = true
	var t := create_tween()
	t.tween_property(fade, "modulate:a", 1.0, 0.5)
	await t.finished
	get_tree().paused = false
	get_tree().change_scene_to_file(path)
	t = create_tween()
	t.tween_property(fade, "modulate:a", 0.0, 0.5)
	await t.finished
	busy = false

func start_game():
	go_to(LEVELS[0])

func next_level():
	var i := LEVELS.find(get_tree().current_scene.scene_file_path)
	if i + 1 < LEVELS.size():
		go_to(LEVELS[i + 1])
	else:
		go_to("res://win.tscn")

func go_to_title():
	go_to("res://title.tscn")

func freeze_time(seconds := 0.25):
	get_tree().paused = true
	await get_tree().create_timer(seconds).timeout
	get_tree().paused = false
