extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_body_2d : AnimatedSprite2D
@export var speed : int 
@export var damage_amount : int = 1

var player : CharacterBody2D
var max_speed : int

func on_process(delta : float):
	pass
	
func on_physics_process(delta : float):
	#print("Physics process of attack_state running")
	var direction : int
	if character_body_2d.global_position > player.global_position:
		animated_body_2d.flip_h = false
		direction = -1
		
	elif character_body_2d.global_position < player.global_position:
		animated_body_2d.flip_h = true
		direction = 1
	animated_body_2d.play("attack")
	
	
	character_body_2d.velocity.x += direction * speed * delta
	character_body_2d.velocity.x = clamp(character_body_2d.velocity.x , -speed , speed)
	character_body_2d.move_and_slide()
	
func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	max_speed = speed + 20
	
func exit():
	pass
