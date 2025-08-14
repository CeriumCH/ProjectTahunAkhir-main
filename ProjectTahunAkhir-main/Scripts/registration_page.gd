extends Control

var ID = ""
var password = ""
var confirm = password

var created = false

func _on_button_pressed() -> void:
	if !created:
		ID = $Panel2/ID_label.text
		password = $Panel2/password_label.text.sha256_text()
		
		created = true
		print("Account created")
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
