extends CharacterBody2D 
var bullet = preload("res://player/Shoot/bullet.tscn")
var player_death_effect = preload("res://player/Player_death_effect/player_death_effect.tscn")
@onready var muzzle : Marker2D = $Muzzle
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_animation_player: AnimationPlayer = $HitAnimationPlayer



const GRAVITY = 1000
const SPEED = 1000
@export var slow_down_speed : int = 2000
@export var max_horizontal_speed : int = 300
const Jump = -300
const Jump_horizontal_speed : int = 1000
@export var max_Jump_horizontal_speed : int = 300
@export var jump_count : int = 1
@export var hold_on_gun_time : float = 2.5

var current_state : State
var muzzle_position 
var character_sprite : Sprite2D
var current_jump_count : int


enum State{Idle , Run , Jump , Shoot , Shoot_Station}

func _ready() -> void:
	current_state = State.Idle
	muzzle_position = muzzle.position
	
func _physics_process(delta: float) -> void:
	player_falling(delta)
	player_Idle()
	player_run(delta)
	player_jump(delta)
	player_muzzle_position()
	player_shooting(delta)
	#if is_on_floor():
		#stationary_shoot(delta)
		#get_tree().create_timer(hold_on_gun_time).timeout
	move_and_slide()
	player_animation()
	#print("State: " , State.keys()[current_state])

func player_falling(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func player_Idle():
	if is_on_floor():
		#print("State: " , State.keys()[current_state])
		current_state = State.Idle

func player_run(delta):
	
	if !is_on_floor():
		return
	
	var direction = Input.get_axis("MOVE_LEFT" , "MOVE_RIGHT")

	if direction:
		velocity.x  += direction * SPEED * delta
		velocity.x = clamp(velocity.x , -max_horizontal_speed , max_horizontal_speed)
	else:
		velocity.x = move_toward(velocity.x , 0 , slow_down_speed*delta)
	if direction != 0:
		current_state = State.Run
		#print("State: " , State.keys()[current_state])
		animated_sprite_2d.flip_h = false if direction > 0 else true

func player_jump(delta):
	var jump_input : bool = Input.is_action_just_pressed("jump")
	
	if is_on_floor() and jump_input:
		current_jump_count = 0
		velocity.y = Jump
		current_jump_count += 1
		current_state = State.Jump
		
	if !is_on_floor() and jump_input and current_jump_count < jump_count:
		velocity.y = Jump
		current_jump_count += 1
		current_state = State.Jump 
		
	if !is_on_floor() and current_state == State.Jump:
		var direction = Input.get_axis("MOVE_LEFT" , "MOVE_RIGHT")
		velocity.x += direction * Jump_horizontal_speed * delta
		velocity.x = clamp(velocity.x , -max_Jump_horizontal_speed , max_Jump_horizontal_speed)

func player_shooting(delta : float):
	var direction = input_movement()
	
	if direction != 0 and Input.is_action_just_pressed("Shoot"):
		var bullet_instance = bullet.instantiate() as Node2D
		bullet_instance.direction = direction
		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)
		current_state = State.Shoot
		 
		

#func stationary_shoot(delta: float):
	#if Input.is_action_just_pressed("Shoot"):
			#var bullet_instance = bullet.instantiate() as Node2D
			#var direction = -1 if animated_sprite_2d.flip_h else 1  # Set direction based on sprite orientation
			#bullet_instance.direction = direction
			#bullet_instance.global_position = muzzle.global_position
			#get_parent().add_child(bullet_instance)
			#current_state = State.Shoot_Station


func player_muzzle_position():
	var direction = input_movement()
	
	if animated_sprite_2d.flip_h:
		muzzle.position.x = -abs(muzzle_position.x)  # Flip to the left
	else:
		muzzle.position.x = abs(muzzle_position.x)  # Flip to the right

	#if direction > 0:
		#muzzle_position.x = abs(muzzle_position.x)  # Ensure it's positive
	#elif direction < 0:
		#muzzle_position.x = -abs(muzzle_position.x)  # Ensure it's negative

func player_death():
	var player_death_effect_instance = player_death_effect.instantiate() as Node2D
	player_death_effect_instance.global_position = global_position
	get_parent().add_child(player_death_effect_instance)
	queue_free()


func player_animation():
	if current_state == State.Idle:
		animated_sprite_2d.play("Idle")
	elif current_state == State.Run and animated_sprite_2d.animation != "Shoot":
		animated_sprite_2d.play("Run")
	elif current_state == State.Shoot:
		animated_sprite_2d.play("Shoot")
	#elif current_state == State.Shoot_Station and animated_sprite_2d.animation != "Run":
		#animated_sprite_2d.play("Station_Shoot")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")

func input_movement():
	var direction : float = Input.get_axis("MOVE_LEFT" , "MOVE_RIGHT")
	return direction


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		#print("Enemy entered " , body.damage_amount)
		hit_animation_player.play("hit")
		HealthManager.decrease_health(body.damage_amount)
		
	if HealthManager.current_health == 0:
		player_death()



func _on_death_area_area_entered(area: Area2D) -> void:
	player_death()
	queue_free()


func _on_death_area_body_entered(body: Node2D) -> void:
	player_death()
	queue_free()
