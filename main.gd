extends CenterContainer

@onready var antz: Sprite2D = $Antz
@onready var limbo_hsm: LimboHSM = $LimboHSM

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	antz.rotate(delta)
