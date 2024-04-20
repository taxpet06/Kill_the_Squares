extends CharacterBody2D
var SPEED = 50
var JUMP_VELOCITY
var chase = false
var p 
var vec = Vector2(0,0)
var can_shoot = true
@onready var b_s = preload("res://en_bullet.tscn")
func _physics_process(_delta):
	if !chase:
		velocity.y = 1*SPEED
		move_and_slide()
	else:
		look_at(p.global_position)
		vec = p.global_position - global_position
		if can_shoot:
			can_shoot = false
			_shoot()
		global_position+= vec.normalized()
func _die():
	$hit.playing = true
	$CollisionShape2D.set_deferred("disabled", true)
	$GPUParticles2D.emitting = true
	$MeshInstance2D.visible = false
	SPEED = 0.0
	JUMP_VELOCITY = 0.0
	await get_tree().create_timer(0.2).timeout
	queue_free()

func _shoot():
	var bullet = b_s.instantiate()
	bullet.position = $Marker2D.global_position
	bullet.dir = vec.normalized()
	get_parent().add_child(bullet)
	await get_tree().create_timer(1).timeout
	can_shoot = true
	pass
	
func _on_area_2d_body_entered(body):
	if body.name == "player":
		p = body
		chase = true
