#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[ attribute(0) ]];
    float3 normal [[ attribute(1) ]];
};

struct Material {
    float4 color;
};

struct ModelConstants {
    float4x4 modelMatrix;
};

struct SceneConstants {
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};

struct RasterizerData {
    float4 position [[ position ]];
    float3 surfaceNormal;
};

vertex RasterizerData basic_vertex_shader(VertexIn vertexIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    float4x4 mvpMatrix = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstants.modelMatrix;
    
    rd.position = mvpMatrix * float4(vertexIn.position, 1.0);
    rd.surfaceNormal = vertexIn.normal;
    
    return rd;
}

fragment half4 basic_fragment_shader(constant Material &material [[ buffer(0) ]]){
    float4 color = material.color;
    
    return half4(color.r, color.g, color.b, color.a);
}
