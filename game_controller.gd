class_name GameController
extends Node

enum ChangeMode {
	DELETE,
	HIDE,
	REMOVE,
}

var current_3d_scene : Node3D
var current_gui_scene : Control

@onready var world_3d: Node3D = $World3D
@onready var gui: Control = $GUI


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.game_controller = self


func change_3d_scene(
		new_scene_path: String, 
		change_mode := ChangeMode.DELETE
	) -> void:
	if current_3d_scene:
		if change_mode == ChangeMode.DELETE:
			current_3d_scene.queue_free() # Removes node entirely
		elif change_mode == ChangeMode.HIDE:
			current_3d_scene.visible = false # Keeps in memory and running
		else:
			world_3d.remove_child(current_3d_scene)	# Keeps in memory, does not run
	
	var load_scene : Loading = load("res://loading.tscn").instantiate()
	load_scene.next_scene_path = new_scene_path
	add_gui_scene(load_scene)
	
	
func add_3d_scene(new_scene : Node3D) -> void:
	world_3d.add_child(new_scene)
	current_3d_scene = new_scene
	

var previous_gui_scene : Control
func change_gui_scene(
		new_scene_path: String, 
		change_mode := ChangeMode.DELETE
	) -> void:
	if current_gui_scene:
		if change_mode == ChangeMode.DELETE:
			current_gui_scene.queue_free() # Removes node entirely
		elif change_mode == ChangeMode.HIDE:
			current_gui_scene.visible = false # Keeps in memory and running
			previous_gui_scene = current_gui_scene
		else:
			gui.remove_child(current_gui_scene)	# Keeps in memory, does not run
	var new_scene = load(new_scene_path).instantiate()
	add_gui_scene(new_scene)
	

func add_gui_scene(new_scene : Control) -> void:
	gui.add_child(new_scene)
	current_gui_scene = new_scene
	
	
func to_previous_gui_scene() -> void:
	current_gui_scene.queue_free()
	current_gui_scene = previous_gui_scene 
	current_gui_scene.visible = true
