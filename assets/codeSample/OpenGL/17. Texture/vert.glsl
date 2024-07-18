#version 410 core

layout(location=0) in vec3 position;
layout(location=1) in vec2 textCoord;

uniform mat4 u_ModelMatrix;
uniform mat4 u_Perspective;
uniform mat4 u_View;

out vec2 v_textCoord;
 
void main()
{
    v_textCoord = textCoord;

    vec4 newPosition = u_Perspective * u_View * u_ModelMatrix * vec4(position, 1.0f);
    gl_Position = vec4(newPosition.x, newPosition.y, newPosition.z, newPosition.w);
}

