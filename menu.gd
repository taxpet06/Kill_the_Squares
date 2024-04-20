extends Node2D
func _on_button_pressed():
	$click.playing = true
	await get_tree().create_timer(0.01).timeout
	get_tree().change_scene_to_file("res://main.tscn")
