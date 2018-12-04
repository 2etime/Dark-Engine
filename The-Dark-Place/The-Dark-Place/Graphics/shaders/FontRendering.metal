#include <metal_stdlib>
#include "SharedMetal.metal"
using namespace metal;

vertex RasterizerData basic_font_vertex(VertexIn vertexIn [[ stage_in ]],
                                        constant float4x4 &projectionMatrix [[ buffer(1) ]],
                                        constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    RasterizerData rd;
    
    float4 offsetPosition = float4(vertexIn.position, 1) + float4(modelConstants.offset, 0);
    rd.position = projectionMatrix * modelConstants.modelMatrix * offsetPosition;
    rd.textureCoordinate = vertexIn.textureCoordinate;
    
    return rd;
}

fragment half4 basic_font_fragment(RasterizerData rd [[ stage_in ]],
                                   texture2d<float> fontTexture [[ texture(0) ]],
                                   sampler fontSampler [[ sampler(0) ]]) {
    float4 color = fontTexture.sample(fontSampler, rd.textureCoordinate);
    
    float gammaCorrection = 1 / 2.2;
    color = float4(pow(color.r, gammaCorrection), pow(color.g, gammaCorrection), pow(color.b, gammaCorrection), color.a);
    
    if(color.a <= 0.00){
        discard_fragment();
    }
    
    
    return half4(color.r, color.g, color.b, color.a);
}
