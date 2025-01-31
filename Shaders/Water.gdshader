shader_type spatial;

uniform vec3 color = vec3(0.1, 0.4, 0.8);
uniform float foamHeight = 0.2;
uniform sampler2D foamTex;

const int WAVE_COUNT = 6;
uniform float amplitudes[WAVE_COUNT];
uniform float waveSpeeds[WAVE_COUNT];
uniform float xAmplifiers[WAVE_COUNT];
uniform float yAmplifiers[WAVE_COUNT];

varying float yOffset;

float calcHeight(float x, float y){
	float offset = 0.0;
	for (int i = 0; i < WAVE_COUNT; i++){
		offset += amplitudes[i] * sin((waveSpeeds[i] * TIME) + (xAmplifiers[i] * (x)) + (yAmplifiers[i] * (y)));
	}
	return offset;
}

void vertex() {
	yOffset = VERTEX.y;
	vec3 b = vec3(VERTEX.x, VERTEX.y + calcHeight(NODE_POSITION_WORLD.x + VERTEX.x + 0.01, NODE_POSITION_WORLD.z + VERTEX.z), VERTEX.z);
	vec3 c = vec3(VERTEX.x, VERTEX.y + calcHeight(NODE_POSITION_WORLD.x + VERTEX.x, NODE_POSITION_WORLD.z + VERTEX.z + 0.1), VERTEX.z);
	VERTEX.y += calcHeight(NODE_POSITION_WORLD.x + VERTEX.x, NODE_POSITION_WORLD.z + VERTEX.z);
	NORMAL = normalize(cross(b - VERTEX, c - VERTEX));
	yOffset += VERTEX.y;
}

void fragment() {
	ALBEDO = color * clamp(1.0 + yOffset, 0.2, 2);
	float strength = yOffset * texture(foamTex, UV).r;
	if (strength >= foamHeight) ALBEDO = ALBEDO + vec3(1, 1, 1) * (strength + foamHeight);
	ALPHA = 0.9;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
