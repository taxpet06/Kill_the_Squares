extends Node2D
var score = 0 
var can_spawn = true
var start = false
@onready var en = preload("res://enemy.tscn")
func _process(_delta):
	if !start:
		if Input.is_action_just_pressed("ui_up"): 
			get_node("player").get_node("jump").playing = true
			start = true
			get_node("player").start = true
			get_node("player").velocity = (Vector2(0,-1) * get_node("player").JUMP_VELOCITY)
	if start:
		$RichTextLabel.visible = true
		$RichTextLabel2.visible = false
		get_node
		$RichTextLabel.text = "SCORE : "+ str(score)
		if can_spawn:
			can_spawn = false
			_spawn()
func _spawn():
	var enemy = en.instantiate()
	enemy.position = Vector2(randi_range(0,1728),randi_range(-978/3,-978))
	add_child(enemy)
	await get_tree().create_timer(randi_range(5,15)).timeout
	can_spawn = true

func _on_replay_pressed():
	$click.playing = true
	await get_tree().create_timer(0.01).timeout
	get_tree().change_scene_to_file("res://main.tscn")
func _on_menu_pressed():
	$click.playing = true
	await get_tree().create_timer(0.01).timeout
	get_tree().change_scene_to_file("res://menu.tscn")
