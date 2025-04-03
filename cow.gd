extends CharacterBody2D
class_name Cow

var switch_dir_time = 0
var time_to_jump = 0


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Handle jump.
	if time_to_jump <= 0:
		velocity.y = JUMP_VELOCITY
		time_to_jump = randfn(4, 4)
	
	time_to_jump -= delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if switch_dir_time <= 0:
		var direction := randi_range(-1,1)
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		switch_dir_time = randfn(3, 3)

	switch_dir_time -= delta
	move_and_slide()
