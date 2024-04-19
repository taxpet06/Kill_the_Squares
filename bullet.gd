extends Area2D
var dir = Vector2(1,1)
var can_die = false
@export var speed = 10
func _physics_process(_delta):
	if collision_layer == 2:
		var vec = $Marker2D.global_position - global_position
		position += vec.normalized()*speed
	else:
		position += dir*speed

func _die():
	$GPUParticles2D.emitting = true
	$MeshInstance2D.visible = false
	dir = Vector2(0,0)
	await get_tree().create_timer(0.2).timeout
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	_die()
func _on_area_entered(area):
	if can_die:
		_die()
func _on_body_entered(body):
	if can_die:
		if body.collision_layer == 8:
			get_parent().score += 1
			body._die()
		elif body.name == "player":
			body._die()
	if can_die:
		_die()
func _on_timer_timeout():
	can_die = true
