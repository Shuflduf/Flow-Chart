shader_type canvas_item;

uniform float circle_radius: hint_range(0.0, 0.5) = 0.5;
uniform vec4 circle_color: source_color;

float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

void fragment() {
	//COLOR.rgb = vec3( circle(UV, circle_radius, 0.005) );
	COLOR.rgb = circle_color.rgb;
	COLOR.a = 1.0 - circle(UV, circle_radius, 0);
}