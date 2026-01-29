class_name SplashSceneManager
extends Control

@export var in_time : float = 0.5
@export var fade_in_time : float = 1.5
@export var pause_time : float = 1.5
@export var fade_out_time : float = 1.5
@export var out_time : float = 0.5

var splash_screens : Array

@onready var splash_screen_container: CenterContainer = $CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	_get_screens()
	_fade()


func _input(event: InputEvent) -> void:
	if event.is_pressed():
		_move_to_next_scene()


func _get_screens() -> void:
	splash_screens = splash_screen_container.get_children()
	for screen in splash_screens:
		screen.modulate.a = 0.0


func _fade() -> void:
	for screen in splash_screens:
		var tween = self.create_tween()
		tween.tween_interval(in_time)
		tween.tween_property(screen, "modulate:a", 1.0, fade_in_time)
		tween.tween_interval(pause_time)
		tween.tween_property(screen, "modulate:a", 0.0, fade_out_time)
		tween.tween_interval(out_time)
		await tween.finished
	_move_to_next_scene()
	
	
func _move_to_next_scene() -> void:
	Global.game_controller.change_gui_scene("res://main_menu.tscn")
	queue_free()
