shader_type spatial;
render_mode world_vertex_coords;

uniform vec3 color = vec3(0.1, 0.4, 0.8);
uniform float foamHeight = 0.2;
uniform float speed = 1.0;
uniform sampler2D foamTex;
uniform float amplitude = 0.2;
uniform float frequency = 1.0;
uniform int waveCount = 5;
uniform float amplitudeScaleFactor = 0.82;
uniform float frequencyScaleFactor = 1.18;
uniform float dirs[40];

varying float yOffset;

float calcHeight(float x, float y){
	float amp = 1.0;
	float freq = 1.0;
	float offset = 0.0;
	for (int i = 0; i < waveCount; i++){
		offset += amplitude * amp * pow(E, sin(frequency * freq * (speed * TIME + (dirs[2 * i] * x) + (dirs[2 * i + 1] * y))));
		amp *= amplitudeScaleFactor;
		freq *= frequencyScaleFactor;
	}
	return offset;
}

void vertex() {
	yOffset = VERTEX.y;
	vec3 b = vec3(VERTEX.x + 0.01, VERTEX.y + calcHeight(VERTEX.x + 0.01, VERTEX.z), VERTEX.z);
	vec3 c = vec3(VERTEX.x, VERTEX.y + calcHeight(VERTEX.x, VERTEX.z + 0.01), VERTEX.z + 0.01);
	VERTEX.y += calcHeight(VERTEX.x, VERTEX.z);
	NORMAL = normalize(cross(c - VERTEX, b - VERTEX));
	yOffset += VERTEX.y;
}

void fragment() {
	ALBEDO = color * clamp(yOffset, 0.2, 11.0);
	//SPECULAR = 1.0;
	float strength = yOffset * texture(foamTex, UV).r;
	if (strength >= foamHeight) ALBEDO = ALBEDO + vec3(1, 1, 1) * (strength + foamHeight);
	ALPHA = 0.9;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
