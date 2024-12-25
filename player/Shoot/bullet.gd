extends AnimatedSprite2D

var bulletimpacteffect = preload("res://player/Shoot/bulletimpacteffect.tscn")
@export var bullet_amount : int = 1
@export var speed : int = 600
@export var direction : int 

func _physics_process(delta: float) -> void:
	move_local_x(direction * speed * delta)


func _on_timer_timeout() -> void:
	queue_free()
	#print("deleted")


func _on_hitbox_area_entered(area: Area2D) -> void:
	bullet_impact()
	#print("bullet_impact")
	

func _on_hitbox_body_entered(body: Node2D) -> void:
	bullet_impact()
	queue_free()

func bullet_impact():
	var bullet_impact_effect_instance = bulletimpacteffect.instantiate() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)


func get_damage_amount()-> int: 
	return bullet_amount
