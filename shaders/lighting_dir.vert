#version 410 core

layout(location=0) in vec3 position;
layout(location=1) in vec3 normal;
layout(location=2) in vec2 textCoord;

uniform mat4 u_ModelMatrix;
uniform mat4 u_Perspective;
uniform mat4 u_View;

out vec2 v_textCoord;
out vec3 v_normal;
out vec3 v_fragPos;
 
void main()
{
    v_textCoord = textCoord;
    v_normal = mat3(transpose(inverse(u_ModelMatrix))) * normal;

    v_fragPos = vec3(u_ModelMatrix * vec4(position, 1.0f));
    vec4 newPosition = u_Perspective * u_View * u_ModelMatrix * vec4(position, 1.0f);
    gl_Position = vec4(newPosition.x, newPosition.y, newPosition.z, newPosition.w);
}
