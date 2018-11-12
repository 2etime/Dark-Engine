#include <metal_stdlib>
#include "SharedMetal.metal"

using namespace metal;

struct TerrainRasterizerData {
    float4 position [[ position ]];
    float3 surfaceNormal;
    float2 textureCoordinate;
    float3 worldPosition;
    float3 toCameraVector;
};

vertex TerrainRasterizerData terrain_vertex_shader(VertexIn vertexIn [[ stage_in ]],
                                            constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                            constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    TerrainRasterizerData trd;
    
    float4 worldPosition = modelConstants.modelMatrix * float4(vertexIn.position, 1.0);
    float4 position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * worldPosition;
    trd.position = position;
    trd.surfaceNormal = (sceneConstants.viewMatrix * (modelConstants.modelMatrix * float4(vertexIn.normal, 0.0))).xyz;
    trd.textureCoordinate = vertexIn.textureCoordinate;
    trd.worldPosition = worldPosition.xyz;
    trd.toCameraVector = (sceneConstants.inverseViewMatrix * float4(0.0,0.0,0.0,1.0)).xyz - worldPosition.xyz;
    
    return trd;
}

fragment half4 terrain_textured_fragment_shader(TerrainRasterizerData rd [[ stage_in ]],
                                                constant Material &material [[ buffer(0) ]],
                                                constant LightData &lightData [[ buffer(1) ]],
                                                sampler sampler2d [[ sampler(0) ]],
                                                texture2d<float> texture [[ texture(0) ]]){
    
    float4 color = texture.sample(sampler2d, rd.textureCoordinate);

    float gammaCorrection = 1 / 2.2;
    color = float4(pow(color.r, gammaCorrection), pow(color.g, gammaCorrection), pow(color.b, gammaCorrection), 1.0);
    
    float3 toLightVector = lightData.position - rd.worldPosition;
    float3 toCameraVector = rd.toCameraVector;
    float3 unitLightVector = normalize(toLightVector);
    float3 unitCameraVector = normalize(toCameraVector);
    float3 unitNormal = normalize(rd.surfaceNormal);
    float3 lightDirection = -unitLightVector;
    
    float3 attenuation = lightData.attenuation;
    float distToLight = length(toLightVector);
    float attFactor = attenuation.x + (attenuation.y * distToLight) + (attenuation.z * distToLight * distToLight);
    
    //Ambient
    float ambientFactor = (lightData.ambientIntensity * material.ambientIntensity);
    float3 ambientColor = mix(color.xyz, lightData.color, ambientFactor) / attFactor;
    
    //Diffuse
    float3 diffuseness = material.diffuseIntensity * lightData.diffuseIntensity;
    float nDot1 = dot(unitNormal, unitLightVector);
    float diffuseBrightness = max(nDot1, 0.1);
    float3 diffuseColor = (diffuseBrightness * diffuseness * lightData.color) / attFactor;
    
    //Specualr
    float3 specularness = material.specularIntensity;
    float3 reflectedLightDirection = reflect(lightDirection, unitNormal);
    float specularFactor = max(saturate(dot(reflectedLightDirection, unitCameraVector)), 0.1);
    float dampedFactor = pow(specularFactor, material.shininess);
    float3 specularColor = (dampedFactor * specularness * lightData.color) / attFactor;
    
    color = float4(ambientColor + diffuseColor + specularColor, color.a);
    return half4(color.r, color.g, color.b, color.a);
}


