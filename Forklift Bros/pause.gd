extends Control
#This restart point is the path of the Scene that you'll go to when you press the restart button.
var restart_point = "res://main_menu.tscn"
@onready var pause_node := $"."
@onready var pause_menu = $PanelContainer
@onready var options_menu = $OptionsMenu

func resume():
	_on_back_button_pressed()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_node.visible = false
	get_tree().paused = false
func pause():
	pause_node.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
func PlayerPause():
	if Input.is_action_just_pressed("ui_cancel") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("ui_cancel") and get_tree().paused:
		resume()

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_node.visible = false
	pause_menu.visible = true
	options_menu.visible = false #In case the I don't click it in the editor by default
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	PlayerPause()



func _on_resume_button_pressed():
	resume()


func _on_restart_button_pressed():
	resume()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file(restart_point)


func _on_quit_button_pressed():
	get_tree().quit()




func _on_option_button_pressed():
	pause_menu.visible = false
	options_menu.visible = true


func _on_back_button_pressed():
	options_menu.visible = false
	pause_menu.visible = true
