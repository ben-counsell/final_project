extends CharacterBody2D

signal player_detected
signal player_escaped_detection
signal arrived_at_path

var speed = 60
var player_target
var pathfinding

@onready var navigation_agent = $NavigationAgent2D

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(_delta):
	if player_target:
		move_towards(player_target.global_position)
	elif pathfinding:
		move_towards(navigation_agent.get_next_path_position())
		if global_position.distance_to(navigation_agent.target_position) < 1:
			pathfinding = false
			arrived_at_path.emit()

func move_towards(target_vector):
	var direction = (target_vector - global_position)
	velocity = direction.normalized() * speed
	move_and_slide()

func _on_detection_area_body_entered(body):
	if body.name == "Player":
		player_detected.emit()
		player_target = body

func _on_detection_area_body_exited(body):
	if body.name == "Player":
		player_escaped_detection.emit()
		player_target = null

func _return_to_path(detection_position):
	navigation_agent.set_target_position(detection_position)
	pathfinding = true
