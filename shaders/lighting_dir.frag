
#version 410 core

struct Material{
    vec3 ambient;
    sampler2D diffuseMap;
    vec3 specular;
    float shininess;
};


struct DirectionalLight
{
    vec3 direction;
    vec3 ambient;
    vec3 specular;
    vec3 diffuse;
};

in vec2 v_textCoord;
in vec3 v_normal;
in vec3 v_fragPos;

out vec4 color;

uniform DirectionalLight dirLight;
uniform Material material;
uniform vec3 cameraPos;

void main()
{

    // Ambient
    vec3 ambient = dirLight.ambient * material.ambient * vec3(texture(material.diffuseMap, v_textCoord));

    // Diffuse
    vec3 normal = normalize(v_normal);

    vec3 lightDir = normalize(-dirLight.direction);
    float NDotL = max(dot(normal, lightDir), 0.0f);
    vec3 diffuse = NDotL * dirLight.diffuse * vec3(texture(material.diffuseMap, v_textCoord));

    // Specular (Blinn Phong)
    vec3 cameraDir = normalize(cameraPos - v_fragPos);
    vec3 half_vec = normalize(cameraDir + lightDir);
    float NDotH = max(dot(normal, half_vec), 0.0f);
    vec3 specular = pow(NDotH, material.shininess) * dirLight.specular * material.specular;


    color = vec4(ambient + diffuse + specular, 1.0f);
}




