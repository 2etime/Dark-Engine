
#include <metal_stdlib>
#include "SharedMetal.metal"
#include <simd/simd.h>
using namespace metal;

struct FragmentOut {
    half4 color [[ color(0) ]];
};

vertex RasterizerData basic_gui_vertex(VertexIn vertexIn [[ stage_in ]],
                                        constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                        constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    float4 offsetPosition = float4(vertexIn.position, 1) + float4(modelConstants.offset, 0);
    rd.position = sceneConstants.projectionMatrix * modelConstants.modelMatrix * offsetPosition;
    rd.textureCoordinate = vertexIn.textureCoordinate;
    
    return rd;
}

fragment FragmentOut basic_gui_fragment(RasterizerData rd [[ stage_in ]]) {
    FragmentOut fo;
    float4 color = float4(1,0,0,1);
    
    fo.color = half4(color.r, color.g, color.b, color.a);
    return fo;
}

