extends Control

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	
	if Firebase.Auth.check_auth_file():
		$Panel/StateLabel.text = "Logged in"
		get_tree().change_scene_to_file("res://Scenes/pick_ems.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_login_pressed() -> void:
	var email = $Panel2/email.text
	var password = $Panel2/password.text
	Firebase.Auth.login_with_email_and_password(email, password)
	$Panel/StateLabel.text = "loggin in"
	
func on_login_succeeded(auth):
	print(auth)
	$Panel/StateLabel.text = "Login success"
	get_tree().change_scene_to_file("res://Scenes/pick_ems.tscn")
	
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	$Panel/StateLabel.text = "Login failed, Error : %s" % message
