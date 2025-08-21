extends Control

var counter := 0
var timer_started = false
@onready var counter_label = $CounterLabel
@onready var spawn_button = $Button
@onready var game_timer = $Timer
@onready var timer_label = $Timer/TimeLabel
var item = preload("res://Scenes/ball.tscn")

func _ready() -> void:
	game_timer.timeout.connect(_on_Timer_timeout) # make sure it's connected!

func _process(delta: float) -> void:
	if timer_started:
		timer_label.text = str("%.2f" % game_timer.time_left)

func _on_button_pressed() -> void:
	if not timer_started:
		game_timer.start()
		timer_started = true

	var ball = item.instantiate()
	add_child(ball)
	ball.position = Vector2(randi_range(100, 200), randi_range(100, 200))

	counter += 1
	counter_label.text = str(counter)

func _on_Timer_timeout() -> void:
	spawn_button.disabled = true
	
	# Show "Game Over" for 2 seconds
	$GameOverLabel.visible = true
	await get_tree().create_timer(5).timeout
	
	# Switch to results
	var result_scene = preload("res://Scenes/Result.tscn").instantiate()
	result_scene.final_score = counter
	get_tree().root.add_child(result_scene)
	queue_free()
