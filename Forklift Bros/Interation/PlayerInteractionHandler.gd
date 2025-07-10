extends Node3D
@export var ItemTypes : Array[ItemData] = []
var Interactables : Array[InteractableItem] = []
var Interacted : bool = false
@onready var hand = $HandReach

func SeeInteractable():
	if hand.is_colliding():
		print("I Can see This object and if it can be picked up it will be picked up")
func OjbectInteraction(event: InputEvent):
	if hand.is_colliding():
		if (event.is_action_pressed("Interact")):
			Interacted = true
		
	pass
func PickupItem(event: InputEvent):
	var Interactables : InteractableItem = null
	if hand.is_colliding():
		if(event.is_action_pressed("Interact")):
			pass
func ItemInteraction(event: InputEvent):
	if hand.is_colliding:
		if (event.is_action_pressed("Interact")):
			print("Interacted")
			pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	SeeInteractable()
