extends Control

func _ready():
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
		
	if Firebase.Auth.check_auth_file():
		$Panel/StateLabel.text = "Logged in"
		call_deferred("goto_game")
		
func _on_button_pressed() -> void:
	var email = $Panel2/ID_label
	var password = $Panel2/password_label
	Firebase.Auth.signup_with_email_and_password(email, password)

func goto_game():
	get_tree().change_scene_to_file("res://Scenes/pick_ems.tscn")
	
func _on_register_pressed() -> void:
	var email = $Panel2/email.text
	var password = $Panel2/password_label.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	$Panel/StateLabel.text = "Signing Up"
	
func on_signup_succeeded(auth):
	print(auth)
	$Panel/StateLabel.text = "Signup success"
	Firebase.Auth.save_auth(auth)
	Firebase.Auth.load_auth()
	get_tree().change_scene_to_file("res://Scenes/pick_ems.tscn")
	
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	$Panel/StateLabel.text = "Signup failed, Error : %s" % message

func _on_logout_pressed() -> void:
	Firebase.Auth.logout()
	print("Logout Success")
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
