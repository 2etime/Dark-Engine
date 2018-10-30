#include <metal_stdlib>
#include "SharedMetal.metal"

using namespace metal;

struct ModelVertexIn {
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
    float3 normal [[ attribute(2) ]];
    float2 textureCoordinate [[ attribute(3) ]];
};

vertex RasterizerData model_vertex_shader(ModelVertexIn vertexIn [[ stage_in ]],
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
