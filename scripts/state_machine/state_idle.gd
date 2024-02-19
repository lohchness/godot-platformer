extends State

@export
var fall_state: State
@export
var jump_state: State
@export
var move_state: State

func enter() -> void:
	super() # Will call top-level State class
	print_debug("Idle")
	
	parent.velocity.x = 0
	
	# Coyote time
	move_component.recently_on_floor = true
	
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		return jump_state
	if Input.is_action_just_pressed('move_left') or Input.is_action_just_pressed('move_right'):
		return move_state
		
	# Case for pressing both directions at the same time
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		return move_state
	if not Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
		return move_state
	
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if not parent.is_on_floor():
		return fall_state
		
	return null
