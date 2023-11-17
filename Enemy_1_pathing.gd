extends Path2D

var inc = 0
var patrol_speed = 100
var enemy_following_path = true

var enemy_script = preload("res://Enemy.gd")
@onready var enemy_instance = $PathFollow2D/Enemy

func _ready():
	enemy_instance.connect("player_detected", _on_player_detected)
	enemy_instance.connect("player_not_detected", _on_player_not_detected)

func _process(delta):
	if enemy_following_path:
		inc += delta * patrol_speed
		$PathFollow2D.progress = inc

func _on_player_detected():
	enemy_following_path = false
	print("should be false: ", enemy_following_path)

func _on_player_not_detected():
	enemy_following_path = true
	print("should be true: ", enemy_following_path)
