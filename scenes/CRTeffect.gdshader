shader_type canvas_item;
render_mode blend_mix;

// Настройки эффекта
uniform float scanline_intensity : hint_range(0, 1) = 0.2;
uniform float noise_intensity : hint_range(0, 1) = 0.1;
uniform float curvature : hint_range(0, 0.1) = 0.02;
uniform float vignette_power : hint_range(0, 5) = 2.0;

uniform float opacity : hint_range(0, 1) = 0.8;

// Псевдо-случайный шум
float rand(vec2 coord) {
	return fract(sin(dot(coord, vec2(12.9898,78.233)) * 43758.5453));
}

void fragment() {
    // Искажение экрана
    vec2 uv = UV;
    uv = uv * 2.0 - 1.0;
    uv *= 1.0 + curvature * length(uv) * length(uv);
    uv = (uv + 1.0) * 0.5;

    // Цвет из текстуры с искажениями
    vec4 color = texture(TEXTURE, uv);

    // Scanlines (горизонтальные линии)
    float scanline = sin(uv.y * 1200.0) * scanline_intensity;
    color.rgb -= scanline;

    // Винитирование (затемнение краев)
    float vignette = 2.5 - pow(length(uv * 2.0 - 1.0), vignette_power);
    color.rgb *= vignette;

    //// Шум
    //color.rgb += (rand(uv + TIME) - 0.5) * noise_intensity;

    COLOR = color;
	COLOR.a *= opacity;
}