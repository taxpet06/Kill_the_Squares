extends CharacterBody2D
var SPEED = 0.07
var JUMP_VELOCITY = 750.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_shoot = true
var vec = Vector2(0,0)
var factor = 2
@onready var b_s = preload("res://bullet.tscn")
func _physics_process(delta):
	velocity.y += gravity * delta * factor
	if Input.is_action_just_pressed("ui_up"):
		vec = $Marker2D.global_position - global_position
		velocity = (vec.normalized() * JUMP_VELOCITY)
	if Input.is_action_pressed("ui_right"):
		rotation += SPEED
	elif Input.is_action_pressed("ui_left"):
		rotation -= SPEED
	else: 
		rotation = lerp(rotation, 0.0, 0.025)
	if Input.is_action_just_pressed("ui_accept") and can_shoot:
		can_shoot = false
		_shoot()
	move_and_slide()
func _shoot():
	var bullet = b_s.instantiate()
	bullet.position = $Marker2D.global_position
	bullet.rotation = rotation
	get_parent().add_child(bullet)
	await get_tree().create_timer(0.1).timeout
	can_shoot = true
	pass
func _die():
	$GPUParticles2D.emitting = true
	$MeshInstance2D.visible = false
	SPEED = 0.0
	JUMP_VELOCITY = 0.0
	factor = 0
	await get_tree().create_timer(0.2).timeout
func _on_visible_on_screen_notifier_2d_screen_exited():
	_die()
