class_name BuoyantBody extends RigidBody3D

enum WaveType{
	SUM_E,
	SUM_G
}

@export var buoyancy: float = 1
@export var samplePoints: Array[Node3D]

func TIME() -> float:
	return fmod(float(Time.get_ticks_msec()) / 1000, 3600)

func getSumEHeight(x: float, y: float) -> float:
	var amp: float = 1
	var freq: float = 1
	var offset: float = 0
	for i: int in range(WaveManager.instance.waveCount):
		offset += WaveManager.instance.amplitude * amp * pow(exp(1), sin(WaveManager.instance.frequency * freq * (WaveManager.instance.speed * TIME() + (WaveManager.instance.dirs[i].x * x) + (WaveManager.instance.dirs[i].y * y))))
		amp *= WaveManager.instance.amplitudeScaleFactor
		freq *= WaveManager.instance.frequencyScaleFactor
	return offset

func getSumGHeight(x: float, y: float) -> float:
	return 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	for i: int in range(samplePoints.size()):
		var distance: float = clampf(getSumEHeight(samplePoints[i].global_position.x, samplePoints[i].global_position.z) - samplePoints[i].global_position.y, 0, 1);
		if (distance > 0):
			apply_force(abs(buoyancy * get_gravity()) * distance, samplePoints[i].position)
