extends Node2D
var score = 0 
var can_spawn = true
@onready var en = preload("res://enemy.tscn")
func _process(_delta):
	$RichTextLabel.text = "SCORE : "+ str(score)
	if can_spawn:
		can_spawn = false
		_spawn()
func _spawn():
	var enemy = en.instantiate()
	enemy.position = Vector2(randi_range(0,1728),-978)
	add_child(enemy)
	await get_tree().create_timer(20).timeout
	can_spawn = true
