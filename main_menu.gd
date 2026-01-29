class_name MainMenu
extends Control


func _on_play_button_pressed() -> void:
	Global.game_controller.change_3d_scene("res://room.tscn")
	var dispose_tween := create_tween()
	dispose_tween.tween_interval(1.0)
	dispose_tween.tween_callback(queue_free)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
