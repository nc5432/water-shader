shader_type canvas_item;

uniform float foamDecayRate = 1.0;
uniform float foamGrowth = 0.05;
uniform float foamHeight = 0.2;
uniform float speed = 1.0;
uniform sampler2D foamTex;
uniform float amplitude = 0.2;
uniform float frequency = 1.0;
uniform int waveCount = 5;
uniform float amplitudeScaleFactor = 0.82;
uniform float frequencyScaleFactor = 1.18;
uniform float dirs[40];
//uniform sampler2D tex: hint_screen_texture;
uniform sampler2D tex;
//global uniform float DELTA;

void fragment() {
	//float brightness = texture(tex, UV).r - (foamDecayRate * DELTA);
	float brightness = clamp(texture(tex, UV).r - foamDecayRate, 0.0, 1.0);
	float amp = 1.0;
	float freq = 1.0;
	float offset = 0.0;
	float x = (UV.x * 50.0) - 25.0;
	float y = (UV.y * 50.0) - 25.0;
	for (int i = 0; i < waveCount; i++){
		offset += amplitude * amp * pow(E, sin(frequency * freq * (speed * TIME + (dirs[2 * i] * x) + (dirs[2 * i + 1] * y))));
		amp *= amplitudeScaleFactor;
		freq *= frequencyScaleFactor;
	}
	//if (offset >= foamHeight * 1.8) brightness += foamGrowth * DELTA;
	if (offset >= foamHeight * 1.8) brightness += foamGrowth;
	COLOR = vec4(brightness, brightness, brightness, 1.0);
	COLOR = texture(tex, UV);
}
