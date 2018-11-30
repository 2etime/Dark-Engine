#include <metal_stdlib>
#include "SharedMetal.metal"
using namespace metal;

vertex RasterizerData basic_font_vertex(VertexIn vertexIn [[ stage_in ]]) {
    RasterizerData rd;
    
    rd.position = float4(vertexIn.position, 1.0);
    rd.textureCoordinate = vertexIn.textureCoordinate;
    
    return rd;
}

fragment half4 basic_font_fragment(RasterizerData rd [[ stage_in ]],
                                   texture2d<float> fontTexture [[ texture(0) ]],
                                   sampler fontSampler [[ sampler(0) ]]) {
    float4 color = fontTexture.sample(fontSampler, rd.textureCoordinate);
    
    float gammaCorrection = 1 / 2.2;
    color = float4(pow(color.r, gammaCorrection), pow(color.g, gammaCorrection), pow(color.b, gammaCorrection), color.a);
    
    if(color.a < 0.02){
        discard_fragment();
    }
    
    
    return half4(color.r, color.g, color.b, color.a);
}
