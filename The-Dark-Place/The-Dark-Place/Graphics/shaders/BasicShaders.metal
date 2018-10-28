#include <metal_stdlib>
#include "SharedMetal.metal"

using namespace metal;

struct Material {
    float4 color;
    float ambientIntensity;
    float diffuseIntensity;
};

struct LightData {
    float3 color;
    float3 position;
    float ambientIntensity;
    float diffuseIntensity;
};

struct RasterizerData {
    float4 position [[ position ]];
    float3 surfaceNormal;
    float2 textureCoordinate;
};

vertex RasterizerData basic_vertex_shader(VertexIn vertexIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    float4 worldPosition = modelConstants.modelMatrix * float4(vertexIn.position, 1.0);
    float4 position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * worldPosition;
    rd.position = position;
    rd.surfaceNormal = (sceneConstants.viewMatrix * (modelConstants.modelMatrix * float4(vertexIn.normal, 0.0))).xyz;
    rd.textureCoordinate = vertexIn.textureCoordinate;
    
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]],
                                     constant Material &material [[ buffer(0) ]]){
    
    LightData lightData;
    lightData.color = float3(1,1,1);
    lightData.position = float3(0,1,3);
    lightData.ambientIntensity = 1.0;
    lightData.diffuseIntensity = 0.5;
    
    float4 color = material.color;
    float3 toLightVector = lightData.position - rd.surfaceNormal;
    
    float3 unitNormal = normalize(rd.surfaceNormal);
    float3 unitToLightVector = normalize(toLightVector);
    
    float ambientFactor = (lightData.ambientIntensity * material.ambientIntensity) / 2;
    float3 ambientColor = mix(color.xyz, lightData.color, ambientFactor);
    
    float diffuseFactor = material.diffuseIntensity * lightData.diffuseIntensity;
    float diffuseBrightness = max(dot(unitNormal, unitToLightVector), 0.0);
    float3 diffuseColor = color.xyz * diffuseBrightness * diffuseFactor;
    
    color = float4(ambientColor + diffuseColor, color.a);
    return half4(color.r, color.g, color.b, color.a);
}

