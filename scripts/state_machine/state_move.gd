extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var jump_state: State

func enter() -> void:
	# parent.animations.play(animation_name)
	print_debug("Move")
	
	# Coyote time
	move_component.recently_on_floor = true
	
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	#if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		#return jump_state
	if move_component.wants_jump() and parent.is_on_floor():
		return jump_state
		
	#if not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		#return idle_state

	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	
	#var movement = Input.get_axis('move_left', 'move_right') * move_speed
	var movement = move_component.get_movement_direction() * move_speed
	
	if movement == 0:
		return idle_state
	
	#if movement != 0:
		##parent.animations.flip_h = movement < 0
		#pass
		
	#parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if not parent.is_on_floor():
		return fall_state
	
	return null
