extends Control

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	print("User data path: ", ProjectSettings.globalize_path("user://"))
	
	if Firebase.Auth.check_auth_file():
		$Panel/StateLabel.text = "Logged in"
		call_deferred("goto_game")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func goto_game():
	get_tree().change_scene_to_file("res://Scenes/set_name.tscn")
	
func _on_login_pressed() -> void:
	var email = $Panel2/email.text
	var password = $Panel2/password.text
	Firebase.Auth.login_with_email_and_password(email, password)
	$Panel/StateLabel.text = "loggin in"
	
func on_login_succeeded(auth):
	print(auth)
	$Panel/StateLabel.text = "Login success"
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://Scenes/set_name.tscn")
	
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	$Panel/StateLabel.text = "Login failed, Error : %s" % message
