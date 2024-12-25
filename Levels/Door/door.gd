extends Node2D
@export var key_id : String
@export var next_scene : String
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var door_open : bool = false

func _on_exit_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var player = body as CharacterBody2D
		player.queue_free()
		
	await get_tree().create_timer(1.0).timeout
	SceneManager.transition_to_scene(next_scene)
	print("scene transition")


func _on_activate_door_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		
		var has_item : bool = InventoryManager.has_inventory_item(key_id)
		
		if !has_item:
			return
		
		if !door_open:
			animated_sprite_2d.play("open")
			door_open = true
			collision_shape_2d.set_deferred("disabled" , true)


func _on_activate_door_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if door_open:
			animated_sprite_2d.play("close")
			door_open = false
			
	else:
		return
