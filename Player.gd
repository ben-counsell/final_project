extends CharacterBody2D

@export var speed = 80.0

func _physics_process(_delta):
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_up", "move_down")
	velocity.x = direction_x
	velocity.y = direction_y
	velocity = velocity.normalized() * speed
	if !velocity:
		$AnimatedSprite2D.play("idle")
	elif velocity.x < 0:
#		$AnimatedSprite2D.flip
		$AnimatedSprite2D.animation = "run"
	move_and_slide()
