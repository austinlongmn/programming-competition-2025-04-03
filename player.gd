extends CharacterBody2D

var lasso_on = false

const SPEED = 300.0
const JUMP_VELOCITY = -1000

var points: int = 0

var lasso_dist = 0

@export var lasso: Node2D
@export var lasso_area_2d: Area2D

@export var points_label: Label
@export var you_win_screen: Control
@export var you_lose_screen: Control


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_key_pressed(KEY_L):
		lasso_dist = move_toward(lasso_dist, 500, delta * 2000)
	else:
		lasso_dist = move_toward(lasso_dist, 0, delta * 2000)
	
	if lasso_dist <= 0.001:
		lasso.visible = false
	else:
		lasso.visible = true

	for body in lasso_area_2d.get_overlapping_bodies():
		if body is Cow:
			body.queue_free()
			points += 1
			points_label.text = "Points: " + str(points)
	
	if points > 5:
		you_win_screen.visible = true
		get_tree().paused = true
	
	if global_position.y > 1000:
		you_lose_screen.visible = true
		get_tree().paused = true

	lasso.position.x = lasso_dist

	move_and_slide()

	
