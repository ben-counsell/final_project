extends RigidBody2D

var speed = .5
var target = null

signal player_detected
signal player_not_detected

func _ready():
	$Sprite2D/AnimationPlayer.play("idle")

func _physics_process(_delta):
	if target:
		var velocity = global_position.direction_to(target.global_position)
		move_and_collide(velocity * speed)

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		player_detected.emit()
		target = body

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		player_not_detected.emit()
		target = null
