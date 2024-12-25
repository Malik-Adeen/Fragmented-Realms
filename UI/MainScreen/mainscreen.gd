extends CanvasLayer

const  SETTINGS_MENU_SCENE = preload("res://UI/MainScreen/SettingsMenuScene.tscn")

func _on_play_button_pressed() -> void:
	GameManager.start_game()
	queue_free()


func _on_exit_button_pressed() -> void:
	GameManager.exit_game()


func _on_settings_button_pressed() -> void:
	var SETTINGS_MENU_SCENE_instance = SETTINGS_MENU_SCENE.instantiate()
	get_tree().get_root().add_child(SETTINGS_MENU_SCENE_instance)
