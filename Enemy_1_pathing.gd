extends Path2D

@onready var patroller = $PathFollow2D/Enemy

signal return_to_path

var progress = 0
var patrol_speed = 80

var patrolling = true
var detection_position = null
var returning_to_path = false

func _ready():
	patroller.connect("player_detected", _on_player_detected)
	patroller.connect("player_escaped_detection", _on_player_escaped_detection)
	patroller.connect("arrived_at_path", _on_return_to_path)

func _process(delta):
	if patrolling:
		$PathFollow2D.progress += delta * patrol_speed

func _on_return_to_path():
	patrolling = true

func _on_player_detected():
	patrolling = false
	returning_to_path = false
	detection_position = patroller.global_position

func _on_player_escaped_detection():
	return_to_path.emit(detection_position)
