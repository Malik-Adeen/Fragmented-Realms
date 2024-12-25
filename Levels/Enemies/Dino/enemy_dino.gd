extends CharacterBody2D
var deatheffect = preload("res://Levels/Enemies/enemydeatheffect.tscn")


@export var health_amount : int = 5
@export var damage_amount : int = 1 


func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass


func _on_hitbox_area_entered(area: Area2D) -> void:
	#print("hurtbox entered")
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node
		health_amount -= node.bullet_amount
		#print("Health Amount :" , health_amount)
		if health_amount <= 0:
			var enemy_death_effect_instance = deatheffect.instantiate() as Node2D
			enemy_death_effect_instance.global_position = global_position
			get_parent().add_child(enemy_death_effect_instance)
			queue_free()
