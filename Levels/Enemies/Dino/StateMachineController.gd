extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine


func _on_attack_area_body_entered(body: Node2D) -> void:
	#print("statemachine func body entered func called")
	if body.is_in_group("Player"):
		#print("transitioning to attack")
		node_finite_state_machine.transition_to("attack")

func _on_attack_area_body_exited(body: Node2D) -> void:
	#print("statemachine func body exited func called")
	if body.is_in_group("Player"):
		#print("transitioning to idle")
		node_finite_state_machine.transition_to("idle")
