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

struct RasterizerData {
    float4 position [[ position ]];
};

vertex RasterizerData basic_vertex_shader(VertexIn vertexIn [[ stage_in ]],
                                          constant ModelConstants &modelConstants [[ buffer(1) ]]) {
    RasterizerData rd;
    
    rd.position = modelConstants.modelMatrix * float4(vertexIn.position, 1.0);
    
    return rd;
}

fragment half4 basic_fragment_shader(constant Material &material [[ buffer(0) ]]){
    float4 color = material.color;
    
    return half4(color.r, color.g, color.b, color.a);
}
