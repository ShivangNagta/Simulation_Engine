#version 410 core


struct Material{
    vec3 ambient;
    sampler2D diffuseMap;
    vec3 specular;
    float shininess;
};


struct Light
{
    vec3 position;
    vec3 ambient;
    vec3 specular;
    vec3 diffuse;
};

in vec2 v_textCoord;
in vec3 v_normal;
in vec3 v_fragPos;

out vec4 color;

uniform Light light;
uniform Material material;
uniform vec3 cameraPos;

void main()
{

    // Ambient
    vec3 ambient = light.ambient * material.ambient;

    // Diffuse
    vec3 normal = normalize(v_normal);

    vec3 lightDir = normalize(light.position - v_fragPos);
    float NDotL = max(dot(normal, lightDir), 0.0f);
    vec3 diffuse = NDotL * light.diffuse * vec3(texture(material.diffuseMap, v_textCoord));

    // Specular (Blinn Phong)
    vec3 cameraDir = normalize(cameraPos - v_fragPos);
    vec3 half_vec = normalize(cameraDir + lightDir);
    float NDotH = max(dot(normal, half_vec), 0.0f);
    vec3 specular = pow(NDotH, material.shininess) * light.specular * material.specular;


    color = vec4(ambient + diffuse + specular, 1.0f);
}
