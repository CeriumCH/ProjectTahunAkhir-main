extends Control

var final_score := 0
var current_score := 0
var time_accumulator := 0.0
var interval := 0.05   # starting speed (fast)
var interval_growth := 0.04  # how much slower each step gets

@onready var score_label = $ScoreLabel
var ball_scene = preload("res://Scenes/ball.tscn")

func _ready():
	score_label.text = "0"

func _process(delta: float) -> void:
	if current_score < final_score:
		time_accumulator += delta
		if time_accumulator >= interval:
			time_accumulator = 0.0
			current_score += 1
			score_label.text = str(current_score)

			var ball = ball_scene.instantiate()
			add_child(ball)
			ball.position = Vector2(randi_range(50, 400), -50)

			# make it slower for the next spawn
			interval += interval_growth
