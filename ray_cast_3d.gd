extends RayCast3D

var block = load("res://dirtblock.tscn")

#onready var raycast : RayCast = $CameraPivot/RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if is_colliding():
		var target = get_collider()
		print_debug()
		if Input.is_action_just_pressed("left_click"):
			print("remove")
			print(target.name)
			target.queue_free()
		if Input.is_action_just_pressed("right_click"):
			var target_position = target.global_position + Vector3.LEFT
