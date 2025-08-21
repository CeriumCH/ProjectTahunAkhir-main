extends Node

@export_file("*.json") var quiz_file_path: String = "res://questions.json"

var question_data = []
var current_index := 0
var score := 0

signal quiz_finished(score: int)

func _ready():
	load_questions_from_json()
	load_question(current_index)
	print("Loaded %d questions" % question_data.size())
	print("LOADED QUESTIONS:", question_data)
	
func end_quiz():
	print("🎉 Quiz ended! Final score: %d" % score)
	await get_tree().create_timer(0.2).timeout  # Give it 200ms to print
	get_tree().change_scene_to_file("res://Scenes/Clicky.tscn")


func load_questions_from_json() -> void:
	print(JSON.stringify(question_data, "\t"))  # nicely formatted
	if not ResourceLoader.exists(quiz_file_path):
		push_error("❌ Quiz file not found: %s" % quiz_file_path)
		return

	var file := FileAccess.open(quiz_file_path, FileAccess.READ)
	var content := file.get_as_text()
	file.close()

	var result = JSON.parse_string(content)
	if result is Array:
		question_data = result as Array[Dictionary]
	else:
		push_error("❌ Invalid JSON format in file.")

func load_question(index: int) -> void:
	if index >= question_data.size():
		if index >= question_data.size():
			emit_signal("quiz_finished", score)
			end_quiz()
			return
		# Disable option buttons
		get_node("../OptionA").disabled = true
		get_node("../OptionB").disabled = true
		get_node("../OptionC").disabled = true
		get_node("../OptionD").disabled = true
		return

	var question: Dictionary = question_data[index]
	var options: Array = question.get("options", [])

	if options.size() < 4:
		push_error("❌ Question %d has only %d options!" % [index, options.size()])
		return

	get_node("../QuestionLabel").text = question.get("text", "No question")
	get_node("../OptionA").text = options[0]
	get_node("../OptionB").text = options[1]
	get_node("../OptionC").text = options[2]
	get_node("../OptionD").text = options[3]

func check_answer(selected: String) -> void:
	var question: Dictionary = question_data[current_index]
	if selected == question.get("correct", ""):
		score += 1
	else:
		score - 1  # Optional penalty

	current_index += 1
	load_question(current_index)
	
# Button presses
func _on_option_a_pressed(): check_answer(get_node("../OptionA").text)
func _on_option_b_pressed(): check_answer(get_node("../OptionB").text)
func _on_option_c_pressed(): check_answer(get_node("../OptionC").text)
func _on_option_d_pressed(): check_answer(get_node("../OptionD").text)
