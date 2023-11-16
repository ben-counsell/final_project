extends CharacterBody2D


const SPEED = 100.0#



func _physics_process(delta):
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction_x
	var direction_y = Input.get_axis("ui_up", "ui_down")
	velocity.y = direction_y
	velocity = velocity.normalized() * SPEED
	$AnimatedSprite2D.flip_h = velocity.x < 0
	$AnimatedSprite2D.play()
#	position += velocity * delta
	move_and_slide()
