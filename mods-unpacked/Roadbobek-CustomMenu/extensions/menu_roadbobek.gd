extends Control

var logo
var progress = 0.0
var eased_progress = 0.0
var duration = 4.0
var logo_loaded = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    logo = get_node("Roadbobek")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if not logo_loaded:
        progress += delta / duration
        eased_progress = ease(progress, 2.0)
        logo.modulate = Color(1.0, 1.0, 1.0, eased_progress * 0.5)
        if eased_progress == 1.0:
            logo_loaded = true  
