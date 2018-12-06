
#include <metal_stdlib>
#include "SharedMetal.metal"
using namespace metal;

vertex RasterizerData basic_gui_vertex(VertexIn vertexIn [[ stage_in ]],
                                        constant float4x4 &projectionMatrix [[ buffer(1) ]],
                                        constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    float4 offsetPosition = float4(vertexIn.position, 1) + float4(modelConstants.offset, 0);
    rd.position = projectionMatrix * modelConstants.modelMatrix * offsetPosition;
    rd.textureCoordinate = vertexIn.textureCoordinate;
    
    return rd;
}

fragment half4 basic_gui_fragment(RasterizerData rd [[ stage_in ]]) {
    float4 color = float4(1,0,0,0.5);
    
    return half4(color.r, color.g, color.b, color.a);
}

