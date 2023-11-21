extends Path2D

@onready var patroller = $PathFollow2D/EnemyNavigator
@onready var animation_player = $PathFollow2D/EnemyNavigator/AnimationPlayer

signal return_to_path

var progress = 0
var patrol_speed = 40

var patrolling = true
var detection_position = null
var returning_to_path = false
var previous_position

func _ready():
	previous_position = global_position

func _physics_process(delta):
	if patrolling:
		$PathFollow2D.progress += delta * patrol_speed
		animate_patrol(previous_position - patroller.global_position)
		previous_position = patroller.global_position

func animate_patrol(direction):
	var velocity = direction.normalized() * patroller.chase_speed
	if velocity.x > 33:
		animation_player.play("running_left", -1, 0.5)
	elif velocity.x < -33:
		animation_player.play("running_right", -1, 0.5)
	elif velocity.y > 0:
		animation_player.play("running_up", -1, 0.5)
	else:
		animation_player.play("running_down", -1, 0.5)

func _on_return_to_path():
	patrolling = true

func _on_player_detected():
	if patrolling:
		patrolling = false
		detection_position = patroller.global_position
	elif returning_to_path:
		returning_to_path = false

func _on_player_escaped_detection():
	return_to_path.emit(detection_position)
