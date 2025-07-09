extends HSlider
@export var music_bus = AudioServer.get_bus_index("Music")
@onready var music_control = $"."
@onready var volume = $"../Volume"

func _on_value_changed(value):
	#Because our volume perception isn't linear like the translated value we need to convert it decibals
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(music_bus,db)
func _on_volume_changed(value: float) -> void:
	var volume_percent = int(value * 100)
	volume.text = str(volume_percent) + "%"

# Called when the node enters the scene tree for the first time.
func _ready():
	music_control.value_changed.connect(_on_volume_changed)
	_on_volume_changed(music_control.value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass

