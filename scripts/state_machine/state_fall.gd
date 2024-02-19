extends State

@export
var idle_state: State
@export
var jump_state: State
@export
var move_state: State

# Jump buffer
@export var jump_buffer_time : float = 0.2
var jump_buffer_timer : float = 0

# Coyote time
@export var coyote_time : float = 0.1
var coyote_timer : float = 0

func enter() -> void:
	super()
	jump_buffer_timer = 0
	coyote_timer = coyote_time
	print_debug("Fall")
	#pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	
	# Jump buffer
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time
	
	# Coyote time
	if Input.is_action_just_pressed("jump") and coyote_timer > 0 and move_component.recently_on_floor:
		return jump_state
	
	return null

func process_frame(delta: float) -> State:
	
	# Jump buffer	
	jump_buffer_timer -= delta
	
	# Coyote time
	coyote_timer -= delta
	if coyote_time < 0:
		move_component.recently_on_floor = false
	
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement != 0:
		#parent.animations.flip_h = movement < 0
		pass
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		
		# Jump buffer		
		if jump_buffer_timer > 0:
			return jump_state
			
		if movement != 0:
			return move_state
		return idle_state
	
	return null
