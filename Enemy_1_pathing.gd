extends Path2D

@onready var patroller = $PathFollow2D/Enemy

signal return_to_path

var inc = 0
var patrol_speed = 80

var patrolling = true
var detection_position = null
var returning_to_path = false

func _ready():
	patroller.connect("player_detected", _on_player_detected)
	patroller.connect("player_not_detected", _on_player_not_detected)
	patroller.connect("arrived_at_path", _on_return_to_path)

func _process(delta):
	if patrolling:
		inc += delta * patrol_speed
		$PathFollow2D.progress = inc

func _on_return_to_path():
	patrolling = true

func _on_player_detected():
	patrolling = false
	returning_to_path = false
	detection_position = patroller.global_position

func _on_player_not_detected():
	return_to_path.emit(detection_position)
