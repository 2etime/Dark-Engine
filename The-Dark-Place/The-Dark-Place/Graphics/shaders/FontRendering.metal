#include <metal_stdlib>
#include "SharedMetal.metal"
using namespace metal;

vertex RasterizerData basic_font_vertex() {
    RasterizerData rd;
    
    
    
    return rd;
}

fragment half4 basic_font_fragment(RasterizerData rd [[ stage_in ]]) {
    float4 color = float4(1,0,0,1);
    
    return half4(color.r, color.g, color.b, color.a);
}
