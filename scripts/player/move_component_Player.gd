extends Node

# Coyote time
var recently_on_floor = false

# Better jump
@export var jump_height : float
@export var jump_time_to_peak : float	
@onready var jump_velocity = (2.0 * jump_height) / jump_time_to_peak * -1.0
@onready var jump_gravity = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak) * -1.0

# Better jump
@export var jump_time_to_descent : float
@onready var fall_gravity = (-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent) * -1.0

# Return the desired direction of movement for the character
# in the range [-1, 1], where positive values indicate a desire
# to move to the right and negative values to the left.
func get_movement_direction() -> float:
	return Input.get_axis('move_left', 'move_right')

# Return a boolean indicating if the character wants to jump
func wants_jump() -> bool:
	return Input.is_action_just_pressed('jump')
