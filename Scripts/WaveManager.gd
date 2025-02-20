class_name WaveManager extends Node

static var instance: WaveManager

@export_category("E^Sin Configuration")
@export var amplitude: float = 1
@export var frequency: float = 1
@export var speed: float = 1
@export var waveCount: int = 5
@export var amplitudeScaleFactor: float = 0.82
@export var frequencyScaleFactor: float = 1.18
@export var dirs: Array[Vector2]

@export_category("Gerstner Wave Configuration")

@export_category("FFT Configuration")

func _enter_tree() -> void:
	if (instance == null || is_instance_valid(instance)): instance = self
	else: queue_free()
