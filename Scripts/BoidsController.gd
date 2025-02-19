class_name BoidsController extends Node3D

@onready var boidScene: PackedScene = preload("res://Scenes/Boid.tscn")

var boids: Array[Boid]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
