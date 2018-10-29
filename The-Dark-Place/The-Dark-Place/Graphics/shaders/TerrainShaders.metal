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

struct TerrainRasterizerData {
    float4 position [[ position ]];
    float3 surfaceNormal;
    float2 textureCoordinate;
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
    
    return trd;
}

fragment half4 terrain_textured_fragment_shader(TerrainRasterizerData rd [[ stage_in ]],
                                                constant Material &material [[ buffer(0) ]],
                                                constant LightData &lightData [[ buffer(1) ]],
                                                texture2d<float> texture [[ texture(0) ]]){
    
    constexpr sampler linearSampler(mip_filter::linear,
                                    mag_filter::linear,
                                    min_filter::linear,
                                    address::repeat);
    
    float4 color = texture.sample(linearSampler, rd.textureCoordinate);
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


