class_name State
extends Node

@export
var animation_name : String
@export
var move_speed : float = 300

# Better jump
#var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity

# Used dependency injection here rather than hardcoding them
var parent: CharacterBody2D
var animations: AnimatableBody2D
var move_component

func enter() -> void:
	#parent.animations.play(animation_name)
	#animations.play(animation_name)
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func get_gravity() -> float:
	return move_component.jump_gravity if parent.velocity.y < 0 else move_component.fall_gravity

# Dash example
func get_movement_input() -> float:
	return move_component.get_movement_direction()
# Dash example
func get_jump() -> bool:
	return move_component.wants_jump()
