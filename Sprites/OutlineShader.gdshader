shader_type canvas_item;

const float width = 1.0;

uniform bool on;

uniform vec4 color : hint_color = vec4(1.0);

bool hasContraryNeighbour(vec2 uv, vec2 texture_pixel_size, sampler2D texture) {
	vec4 currentColor = texture(texture, uv);
	for (float i = -width; i <= width; i++) {
		for (float j = -width; j <= width; j++) {
			vec2 offset = vec2(i, j) * texture_pixel_size;
			vec4 neighbour = texture(texture, uv + offset);
			if (currentColor.a == 0.0 && neighbour.a != 0.0) {
				return true;
			}
		}
	}
	
	return false;
}

void fragment() {
	vec2 uv = UV;
	COLOR = texture(TEXTURE, uv);
	if (on && hasContraryNeighbour(uv, TEXTURE_PIXEL_SIZE, TEXTURE)) {
		COLOR = color;
	}
}