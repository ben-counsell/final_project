extends CharacterBody2D

@export var speed = 80
var target = null
var path_return_point = null

signal player_detected
signal player_not_detected
signal arrived_at_path

func _ready():
	$Sprite2D/AnimationPlayer.play("idle")

func _physics_process(_delta):
	if target:
		var velocity = (target.global_position - global_position).normalized()
		move_and_collide(velocity)
	if path_return_point:
		var velocity = (path_return_point - global_position).normalized()
		move_and_collide(velocity)
		if global_position.distance_to(path_return_point) < 2:
			arrived_at_path.emit()
			path_return_point = null

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		player_detected.emit()
		target = body

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		player_not_detected.emit()
		target = null

func _return_to_path(detection_position):
	path_return_point = detection_position
