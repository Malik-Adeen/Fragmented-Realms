extends CanvasLayer

@onready var collectalbe_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/CollectalbeLabel


func _ready():
	CollectablesManager.on_collectable_award_recieved.connect(on_collectable_award_recieved)
	
	
func on_collectable_award_recieved(total_award : int):
	collectalbe_label.text = str(total_award)


func _on_pause_texture_button_pressed() -> void:
	GameManager.pause_game()
