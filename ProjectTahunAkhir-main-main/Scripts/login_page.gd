extends Control

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	
	if Firebase.Auth.check_auth_file():
		Firebase.Auth.load_auth()
		$Panel/StateLabel.text = "Logged in"
		call_deferred("goto_game")
	else:
		print("No auth file yet, waiting for login...")

func goto_game():
	get_tree().change_scene_to_file("res://Scenes/set_name.tscn")
	
func _on_login_pressed() -> void:
	var email = $Panel2/email.text
	var password = $Panel2/password.text
	Firebase.Auth.login_with_email_and_password(email, password)
	$Panel/StateLabel.text = "Logging in..."
	
func on_login_succeeded(auth):
	print(auth)
	$Panel/StateLabel.text = "Login success"
	Firebase.Auth.save_auth(auth)
	Firebase.Auth.load_auth()
	get_tree().change_scene_to_file("res://Scenes/set_name.tscn")
	
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	$Panel/StateLabel.text = "Login failed, Error : %s" % message
