
#include <metal_stdlib>
#include "SharedMetal.metal"
using namespace metal;


vertex RasterizerData instanced_vertex_shader(const VertexIn vertexIn [[ stage_in ]],
                                              constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                              constant ModelConstants *modelConstants [[ buffer(2) ]],
                                              uint instanceId [[ instance_id ]]){
    RasterizerData rd;
    
    ModelConstants modelConstant = modelConstants[instanceId];
    float4 worldPosition = modelConstant.modelMatrix * float4(vertexIn.position, 1.0);
    float4 position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * worldPosition;
    rd.position = position;
    rd.surfaceNormal = (modelConstant.modelMatrix * float4(vertexIn.normal, 0.0)).xyz;
    rd.textureCoordinate = vertexIn.textureCoordinate;
    rd.worldPosition = worldPosition.xyz;
    rd.toCameraVector = (sceneConstants.inverseViewMatrix * float4(0.0,0.0,0.0,1.0)).xyz - worldPosition.xyz;
    
    return rd;
}
