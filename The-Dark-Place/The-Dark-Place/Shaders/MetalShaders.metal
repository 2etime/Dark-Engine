#include <metal_stdlib>
using namespace metal;

struct Vertex {
    float3 position;
};

struct RasterizerData {
    float4 position [[ position ]];
};

vertex RasterizerData basic_vertex_shader(constant Vertex *vertices [[ buffer(0) ]],
                                          const uint vertexID [[ vertex_id ]]) {
    RasterizerData rd;
    
    rd.position = float4(vertices[vertexID].position, 1.0);
    
    return rd;
}

fragment half4 basic_fragment_shader(){
    return half4(1,0,0,1);
}
