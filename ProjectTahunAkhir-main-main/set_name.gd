extends Control

var COLLECTION_ID = "player_stats"

func _ready() -> void:
	Firebase.Auth.load_auth()
	
func _on_submit_pressed() -> void:
	save_data()
	
func save_data():
	var auth = Firebase.Auth.auth
	if auth == null or not auth.has("localId"):
		print("No user logged in, cannot save.")
		return

	var uid = auth["localId"]
	var collection = Firebase.Firestore.collection(COLLECTION_ID)

	var player_name = $NameInsert.text.strip_edges()
	if player_name == "":
		player_name = "User"

	var data = {"player_name": player_name}

	var document = await collection.get_doc(uid)
	if document:
		await collection.update(uid, data)
		print("Updated Firestore doc for", uid)
	else:
		await collection.set(uid, data)
		print("Created Firestore doc for", uid)
