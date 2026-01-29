shader_type canvas_item;

uniform vec4 background_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

uniform float erosion : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D erosion_texture;
uniform vec4 erosion_edge_color : source_color = vec4(1.0);
uniform float erosion_edge_size = 0.05;

float erode(vec2 uv)
{
	float noise = texture(erosion_texture, uv).r;
	float erosion_step_in = (1.0 + erosion_edge_size) * erosion - erosion_edge_size;
	return step(erosion_step_in, noise);
}

float erode_edge(vec2 uv)
{
    float noise = texture(erosion_texture, uv).r;
	float erosion_step_in = (1.0 + erosion_edge_size) * erosion - erosion_edge_size;
    return 1.0 - step(erosion_step_in, noise - erosion_edge_size);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.

	float erode_val = erode(UV);
	float erode_edge_val = erode_edge(UV);

	if (erode_val == 0.0)
		discard;

	COLOR = mix(background_color, erosion_edge_color, erode_edge_val);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
