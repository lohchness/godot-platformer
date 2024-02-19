extends State

@export
var fall_state: State
@export
var idle_state: State
@export
var move_state: State

@export
var jump_force: float = 700.0

func enter() -> void:
	super()
	# Better jump
	#parent.velocity.y = -jump_force
	parent.velocity.y = move_component.jump_velocity
	print_debug("Jump")
	
	# Coyote time
	move_component.recently_on_floor = false

func process_physics(delta: float) -> State:
	# Better jump
	#parent.velocity.y += gravity * delta
	parent.velocity.y += get_gravity() * delta
	
	# Switch to fall state if player no longer moving upward
	if parent.velocity.y > 0:
		return fall_state
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement != 0:
		#parent.animations.flip_h = movement < 0
		pass
		
	## Push off ledges
	#if parent.right_outer.is_colliding() and not parent.right_inner.is_colliding() \
		#and not parent.left_inner.is_colliding() and not parent.left_outer.is_colliding():
		#parent.position.x -= 14.27 
	#elif not parent.right_outer.is_colliding() and not parent.right_inner.is_colliding() \
		#and not parent.left_inner.is_colliding() and parent.left_outer.is_colliding():
		#parent.position.x += 14.27
		#
		
	parent.velocity.x = movement
	parent.move_and_slide()
	
	# Transition to move or idle state if on floor depending on any keys pressed
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	
	return null
