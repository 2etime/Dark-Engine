#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[ attribute(0) ]];
};

struct Material {
    float4 color;
};

struct ModelConstants {
    float4x4 modelMatrix;
};

struct SceneConstants {
    float4x4 viewMatrix;
};

struct RasterizerData {
    float4 position [[ position ]];
};

vertex RasterizerData basic_vertex_shader(VertexIn vertexIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    float4x4 mvMatrix = sceneConstants.viewMatrix * modelConstants.modelMatrix;
    
    rd.position = mvMatrix * float4(vertexIn.position, 1.0);
    
    return rd;
}

fragment half4 basic_fragment_shader(constant Material &material [[ buffer(0) ]]){
    float4 color = material.color;
    
    return half4(color.r, color.g, color.b, color.a);
}
