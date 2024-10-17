extends CharacterBody3D


const SPEED = 4
const JUMP_VELOCITY = 2.5



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var block = load("res://dirtblock.tscn")
#var floor = null
var pivot = null
var raycast = null
var placement = load("res://character_body_3d.tscn")



func _ready():
	axis_lock_angular_x = true
	pivot = $CameraPivot
	raycast = $RayCast3D
	#floor = $Floor
	
	
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	
	for x in range(50):
		for y in range(10):
			for z in range(50):
				var new_instance = block.instantiate()
				new_instance.global_position = Vector3(x,randi_range(y -10,-3),z);
				get_tree().root.add_child.call_deferred(new_instance)
				print(x)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("right_click"):
		var new_instance = block.instantiate()
		#new_instance.global_position = self.global_position
		new_instance.global_position = self.global_position + Vector3(0,0.5,0)
		#new_instance.rotation = self.rotation
		get_tree().root.add_child(new_instance)
		
	
	

	#if Input.is_action_just_pressed("left_click"):
		#var new_instance = block.queue_free()
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	rotation.y -= Input.get_last_mouse_velocity().x/100 * delta
	
		
	pivot.rotation.x -= Input.get_last_mouse_velocity().y/100 * delta
	if (pivot.rotation_degrees.x >= 90):
		pivot.rotation_degrees.x = 90
	if (pivot.rotation_degrees.x <= -90):
		pivot.rotation_degrees.x = -90

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


	move_and_slide()
