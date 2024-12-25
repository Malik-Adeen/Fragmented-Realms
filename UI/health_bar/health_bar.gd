extends Node2D

@export var hearth1 : Texture2D
@export var hearth0 : Texture2D


@onready var hearth_0: Sprite2D = $Sprite2D
@onready var hearth_1: Sprite2D = $Sprite2D2
@onready var hearth_2: Sprite2D = $Sprite2D3


func _ready():
	HealthManager.on_health_changed.connect(on_player_health_changed)

func on_player_health_changed(player_current_health : int):
	if player_current_health == 3:
		hearth_1.texture = hearth1
		
	elif player_current_health < 3:
		hearth_1.texture = hearth0
		
	if player_current_health == 2:
		hearth_2.texture = hearth1
		
	elif player_current_health < 2:
		hearth_2.texture = hearth0
		
	if player_current_health == 1:
		hearth_0.texture = hearth1
		
	elif player_current_health < 1:
		hearth_0.texture = hearth0
