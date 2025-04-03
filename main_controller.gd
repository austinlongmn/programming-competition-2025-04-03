extends Node2D

var time_to_spawn = 0
const max_time_to_spawn = 3

@export var cow_scene: PackedScene

func _physics_process(delta: float) -> void:
	if time_to_spawn <= 0.01:
		spawn_cow()
		time_to_spawn = randfn(max_time_to_spawn, 3)
	
	time_to_spawn -= delta

func spawn_cow():
	var cow = cow_scene.instantiate()

	add_child(cow)
