#include <metal_stdlib>
#include "SharedMetal.metal"

using namespace metal;

struct LightData {
    float3 color;
    float3 position;
    float ambientIntensity;
    float diffuseIntensity;
};

vertex RasterizerData basic_vertex_shader(VertexIn vertexIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    float4 worldPosition = modelConstants.modelMatrix * float4(vertexIn.position, 1.0);
    float4 position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * worldPosition;
    rd.position = position;
    rd.surfaceNormal = (modelConstants.modelMatrix * float4(vertexIn.normal, 0.0)).xyz;
    rd.textureCoordinate = vertexIn.textureCoordinate;
    rd.worldPosition = worldPosition.xyz;
    rd.toCameraVector = (sceneConstants.inverseViewMatrix * float4(0.0,0.0,0.0,1.0)).xyz - worldPosition.xyz;
    
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]],
                                     constant Material &material [[ buffer(0) ]],
                                     texture2d<float> texture [[ texture(0) ]],
                                     constant LightData &lightData [[ buffer(1) ]]){
    
    constexpr sampler linearSampler(mip_filter::linear,
                                    mag_filter::linear,
                                    min_filter::linear);
    
    float4 color = material.useTexture ? texture.sample(linearSampler, rd.textureCoordinate) : material.color;
    
    float3 toLightVector = lightData.position - rd.worldPosition;
    float3 toCameraVector = rd.toCameraVector;
    float3 unitLightVector = normalize(toLightVector);
    float3 unitCameraVector = normalize(toCameraVector);
    float3 unitNormal = normalize(rd.surfaceNormal);
    float3 lightDirection = -unitLightVector;
    
    //Ambient
    float ambientFactor = (lightData.ambientIntensity * material.ambientIntensity) / 2;
    float3 ambientColor = mix(color.xyz, lightData.color, ambientFactor);
    
    //Diffuse
    float3 diffuseness = material.diffuseIntensity * lightData.diffuseIntensity;
    float nDot1 = dot(unitNormal, unitLightVector);
    float diffuseBrightness = max(nDot1, -1.0);
    float3 diffuseColor = (diffuseBrightness * diffuseness * lightData.color);
    
    //Specualr
    float3 specularness = material.specularIntensity;
    float3 reflectedLightDirection = reflect(lightDirection, unitNormal);
    float specularFactor = max(saturate(dot(reflectedLightDirection, unitCameraVector)), 0.1);
    float dampedFactor = pow(specularFactor, material.shininess);
    float3 specularColor = (dampedFactor * specularness * lightData.color);
    
    color = float4(ambientColor + diffuseColor + specularColor, color.a);
    if(color.a <= 0.1) discard_fragment();
    
    return half4(color.r, color.g, color.b, color.a);
}
