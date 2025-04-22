class_name ShaderController extends Control

@export var eSinShader: ShaderMaterial
@export var gerstnerShader: ShaderMaterial
@export var maxWaveCount: int = 100

var mode: int = 0

func _ready() -> void:
	var dirs: Array[float]
	for i: int in range(maxWaveCount * 2):
		dirs.append(randf_range(-1, 1))
	eSinShader.set_shader_parameter("dirs", dirs)
	gerstnerShader.set_shader_parameter("dirs", dirs)

func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			$"../ESin".show()
			$"../Gerstner".hide()
			$PanelContainer/MarginContainer/VBoxContainer/ESin.show()
			$PanelContainer/MarginContainer/VBoxContainer/Gerstner.hide()
			mode = 0
		1:
			$"../ESin".hide()
			$"../Gerstner".show()
			$PanelContainer/MarginContainer/VBoxContainer/ESin.hide()
			$PanelContainer/MarginContainer/VBoxContainer/Gerstner.show()
			mode = 1

func _on_color_picker_button_color_changed(color: Color) -> void:
	match mode:
		0:
			eSinShader.set_shader_parameter("color", Vector3(color.r, color.g, color.b))
			eSinShader.set_shader_parameter("opacity", color.a)
		1:
			gerstnerShader.set_shader_parameter("color", Vector3(color.r, color.g, color.b))
			gerstnerShader.set_shader_parameter("opacity", color.a)

func _on_wave_count_value_changed(value: float) -> void:
	match mode:
		0:
			eSinShader.set_shader_parameter("waveCount", value)
		1:
			gerstnerShader.set_shader_parameter("waveCount", value)

func _on_speed_value_changed(value: float) -> void:
	match mode:
		0:
			eSinShader.set_shader_parameter("speed", value)
		1:
			gerstnerShader.set_shader_parameter("speed", value)

func _on_amplitude_value_changed(value: float) -> void:
	match mode:
		0:
			eSinShader.set_shader_parameter("amplitude", value)
		1:
			gerstnerShader.set_shader_parameter("amplitude", value)

func _on_amplitude_scale_value_changed(value: float) -> void:
	match mode:
		0:
			eSinShader.set_shader_parameter("amplitudeScaleFactor", value)
		1:
			gerstnerShader.set_shader_parameter("amplitudeScaleFactor", value)

func _on_frequency_value_changed(value: float) -> void:
	match mode:
		0:
			eSinShader.set_shader_parameter("frequency", value)
		1:
			gerstnerShader.set_shader_parameter("frequency", value)

func _on_frequency_scale_value_changed(value: float) -> void:
	match mode:
		0:
			eSinShader.set_shader_parameter("frequencyScaleFactor", value)
		1:
			gerstnerShader.set_shader_parameter("frequencyScaleFactor", value)

func _on_button_pressed() -> void:
	match mode:
		0:
			eSinShader.set_shader_parameter("color", Vector3(0.1, 0.4, 0.8))
			eSinShader.set_shader_parameter("opacity", 0.95)
			$PanelContainer/MarginContainer/VBoxContainer/ESin/HBoxContainer/ColorPickerButton.color = Color(0.1, 0.4, 0.8, 0.95)
			eSinShader.set_shader_parameter("waveCount", 20)
			$PanelContainer/MarginContainer/VBoxContainer/ESin/HBoxContainer7/HSlider.value = 20
			eSinShader.set_shader_parameter("speed", 1.2)
			$PanelContainer/MarginContainer/VBoxContainer/ESin/HBoxContainer2/HSlider.value = 1.2
			eSinShader.set_shader_parameter("amplitude", 0.075)
			$PanelContainer/MarginContainer/VBoxContainer/ESin/HBoxContainer3/HSlider.value = 0.075
			eSinShader.set_shader_parameter("amplitudeScaleFactor", 0.72)
			$PanelContainer/MarginContainer/VBoxContainer/ESin/HBoxContainer4/HSlider.value = 0.72
			eSinShader.set_shader_parameter("frequency", 1.6)
			$PanelContainer/MarginContainer/VBoxContainer/ESin/HBoxContainer6/HSlider.value = 1.6
			eSinShader.set_shader_parameter("frequencyScaleFactor", 1.325)
			$PanelContainer/MarginContainer/VBoxContainer/ESin/HBoxContainer5/HSlider.value = 1.325
		1:
			gerstnerShader.set_shader_parameter("color", Vector3(0.1, 0.4, 0.8))
			gerstnerShader.set_shader_parameter("opacity", 0.95)
			$PanelContainer/MarginContainer/VBoxContainer/Gerstner/HBoxContainer/ColorPickerButton.color = Color(0.1, 0.4, 0.8, 0.95)
			gerstnerShader.set_shader_parameter("waveCount", 20)
			$PanelContainer/MarginContainer/VBoxContainer/Gerstner/HBoxContainer7/HSlider.value = 20
			gerstnerShader.set_shader_parameter("speed", 1.545)
			$PanelContainer/MarginContainer/VBoxContainer/Gerstner/HBoxContainer2/HSlider.value = 1.545
			gerstnerShader.set_shader_parameter("amplitude", 0.2)
			$PanelContainer/MarginContainer/VBoxContainer/Gerstner/HBoxContainer3/HSlider.value = 0.2
			gerstnerShader.set_shader_parameter("amplitudeScaleFactor", 0.77)
			$PanelContainer/MarginContainer/VBoxContainer/Gerstner/HBoxContainer4/HSlider.value = 0.77
			gerstnerShader.set_shader_parameter("frequency", 1.29)
			$PanelContainer/MarginContainer/VBoxContainer/Gerstner/HBoxContainer6/HSlider.value = 1.29
			gerstnerShader.set_shader_parameter("frequencyScaleFactor", 1.225)
			$PanelContainer/MarginContainer/VBoxContainer/Gerstner/HBoxContainer5/HSlider.value = 1.225
