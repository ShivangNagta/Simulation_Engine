#version 410 core
in vec2 vTexCoords;
out vec4 FragColor;

uniform vec3 topColor;
uniform vec3 bottomColor;

void main() {
    FragColor = vec4(mix(bottomColor, topColor, vTexCoords.y), 1.0);
}
