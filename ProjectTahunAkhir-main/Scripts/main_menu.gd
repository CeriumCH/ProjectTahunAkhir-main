extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_login_pressed() -> void:
	print("Fly me to the Login Page")
	get_tree().change_scene_to_file("res://Scenes/login_page.tscn")


func _on_register_pressed() -> void:
	print("Fly me to the Registration Page")
	get_tree().change_scene_to_file("res://Scenes/registration_page.tscn")
