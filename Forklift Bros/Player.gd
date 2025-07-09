extends CharacterBody3D
var mounse_sensitivity := .1
var twist_input := 0.0
var pitch_input := 0.0
var speed
const WALK_SPEED = 5.0
const RUN_SPEED = 10.0
const JUMP_VELOCITY = 4.5
const LOOKAROUND_SPEED = .01
var rot_x = 0
var rot_y = 0
@export var cameras : Array[Camera3D]= []
var current_index = 0 

#Bobbing Vars
const BOB_FREQ = 2
const BOB_AMP = 0.08
var t_bob = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func POV_Change():
	for i in range(cameras.size()):
		cameras[i].current= (i == current_index)
		
func Looking_Around(event):
	if event is InputEventMouseMotion :
		rot_y -= event.relative.x * LOOKAROUND_SPEED
		rot_x -= event.relative.y * LOOKAROUND_SPEED
		rot_x = clamp(rot_x, -90, 90)
		rotation_degrees = Vector3(rot_x, rot_y, 0)
func _input(event):
	if get_tree().paused == false:
		Looking_Around(event)
	
	

func _physics_process(delta):
	
	
	
	if Input.is_action_just_pressed("POV CHANGE"):
		current_index= (current_index +1)% cameras.size() 
		POV_Change()
		
	
	if Input.is_action_pressed("Sprint"):
		speed = RUN_SPEED
	else: 
		speed = WALK_SPEED
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else :
		velocity.x = 0.0
		velocity.z = 0.0
		
	move_and_slide()
		
		
		
	#Head Bob
	t_bob +=delta * velocity.length() * float(is_on_floor())
	$Head/HeadCamera.transform.origin = _headbob(t_bob)
	
	# Handle Jump.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _headbob(time)-> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) *BOB_AMP
	pos.x = cos(time *BOB_FREQ/ 2) *BOB_AMP
	return pos
