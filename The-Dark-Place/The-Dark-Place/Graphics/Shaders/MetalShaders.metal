#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[ attribute(0) ]];
};

struct RasterizerData {
    float4 position [[ position ]];
};

vertex RasterizerData basic_vertex_shader(VertexIn vertexIn [[ stage_in ]]) {
    RasterizerData rd;
    
    rd.position = float4(vertexIn.position, 1.0);
    
    return rd;
}

fragment half4 basic_fragment_shader(){
    return half4(1,0,0,1);
}
