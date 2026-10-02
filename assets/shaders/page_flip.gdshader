shader_type canvas_item;

uniform float fold_x: hint_range(0.0, 1.0, 0.01) = 0.0;
uniform float fold_y: hint_range(0.0, 1.0, 0.01) = 0.0;
uniform float normal_x: hint_range(0.0, 1.0, 0.01) = 0.0;
uniform float normal_y: hint_range(0.0, 1.0, 0.01) = 0.0;
uniform sampler2D next_page;

vec3 get_next_page_pixel(vec2 uv, float page_dist) {
	vec3 color = texture(next_page, uv).rgb;
	return color;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	vec2 resolution = 1.0 / TEXTURE_PIXEL_SIZE;
	vec3 color = texture(TEXTURE, UV).rgb;
	vec2 aspect = vec2(resolution.x / resolution.y, 1.0);
	vec2 fold = vec2(1.0 - fold_x, 1.0 - fold_y) * aspect;
	vec2 normal = normalize(vec2(normal_x, normal_y) * aspect);
	vec2 page_uv = uv * aspect - fold;
	float page_side = dot(page_uv, normal);
	if (page_side > 0.0) {
		color = get_next_page_pixel(uv, page_side);
	} 
	else {
		
	}
	COLOR = vec4(color, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
