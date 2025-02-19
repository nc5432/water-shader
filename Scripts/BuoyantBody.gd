extends RigidBody3D

enum WaveType{
	SUM_E,
	SUM_G
}

@export var samplePoints: Array[Node3D]

func getSumEHeight(x: float, y: float) -> float:
	return 0

func getSumGHeight(x: float, y: float) -> float:
	return 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	pass
