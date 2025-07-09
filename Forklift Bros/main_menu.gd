extends Node3D

@onready var camera_pivot = $CameraPivot
# Called when the node enters the scene tree for the first time.
var rotation_speed = 8
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera_pivot.rotation_degrees.y += delta * rotation_speed 
