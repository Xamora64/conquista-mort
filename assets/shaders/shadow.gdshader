shader_type canvas_item;
// Shader generated with claude

uniform vec2 shadow_offset = vec2(6.0, 6.0);
uniform vec2 shadow_scale = vec2(1.2, 1.2);
uniform vec4 shadow_color : source_color = vec4(0.0, 0.0, 0.0, 0.5);

float in_bounds(vec2 uv) {
	return step(0.0, uv.x) * step(uv.x, 1.0) * step(0.0, uv.y) * step(uv.y, 1.0);
}

void vertex() {
	vec2 tex_size = 1.0 / TEXTURE_PIXEL_SIZE;
	// Marge calculée pour contenir l'ombre décalée et agrandie
	vec2 margin = abs(shadow_offset) + max(shadow_scale - 1.0, vec2(0.0)) * 0.5 * tex_size + 1.0;
	vec2 dir = UV * 2.0 - 1.0;
	VERTEX += dir * margin;
	UV = (UV * tex_size + dir * margin) / tex_size;
}

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	col.a *= in_bounds(UV);

	vec2 shadow_uv = UV - shadow_offset * TEXTURE_PIXEL_SIZE;
	shadow_uv = (shadow_uv - 0.5) / shadow_scale + 0.5;
	float shadow_a = texture(TEXTURE, shadow_uv).a * in_bounds(shadow_uv) * shadow_color.a;

	COLOR.rgb = mix(shadow_color.rgb, col.rgb, col.a);
	COLOR.a = col.a + shadow_a * (1.0 - col.a);
}