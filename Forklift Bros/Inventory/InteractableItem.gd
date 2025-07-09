extends Node3D
class_name InteractableItem

@export var ItemHighlightMesh : MeshInstance3D

func GainFocus():
	ItemHighlightMesh.visible = true
	pass
func LoseFocus():
	ItemHighlightMesh.visible = true
	pass
