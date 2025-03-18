shader_type canvas_item;

uniform vec4 color : source_color = vec4(0.06, 0.11, 0.15, 1.0); // #0f1b26
uniform vec2 center;
uniform float radius : hint_range(0.0, 1.0) = 0.0; // Начальное значение 0
uniform vec2 viewport_size = vec2(256.0, 240.0); // Ваш размер экрана
uniform float pixel_scale = 1.0;

void fragment() {
    // Пикселизация координат
    vec2 pixel_uv = floor(UV * viewport_size / pixel_scale) * (pixel_scale / viewport_size);

    // Расчет расстояния
    float dist = length(pixel_uv - center);
    float alpha = step(radius, dist);

    COLOR = vec4(color.rgb, alpha);
}