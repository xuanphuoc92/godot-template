class_name Loading
extends Control

@export var next_scene_path : String

var is_playing : bool : 
	get: return animation_player.is_playing()

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("in")
	ResourceLoader.load_threaded_request(next_scene_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_playing:
		return
	
	var status = ResourceLoader.load_threaded_get_status(next_scene_path)
	match status:
		ResourceLoader.THREAD_LOAD_LOADED:
			animation_player.play("out")
			var scene = ResourceLoader.load_threaded_get(next_scene_path).instantiate()
			Global.game_controller.add_3d_scene(scene)
			await animation_player.animation_finished			
			Global.game_controller.gui.visible = false
			queue_free()
