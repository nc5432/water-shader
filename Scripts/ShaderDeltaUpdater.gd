extends Node

func _process(delta: float) -> void:
	RenderingServer.global_shader_parameter_set("DELTA", delta)
