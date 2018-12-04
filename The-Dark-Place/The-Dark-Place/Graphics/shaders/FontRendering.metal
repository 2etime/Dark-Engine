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

constant static float width = 0.51;
constant static float edge = 0.02;

fragment half4 basic_font_fragment(RasterizerData rd [[ stage_in ]],
                                   texture2d<float> fontAtlas [[ texture(0) ]],
                                   sampler fontSampler [[ sampler(0) ]]) {
    
    float gammaCorrection = 1 / 2.2;
    float4 color = fontAtlas.sample(fontSampler, rd.textureCoordinate);
    color = float4(pow(color.r, gammaCorrection), pow(color.g, gammaCorrection), pow(color.b, gammaCorrection), color.a);
    
    float dist = 1.0 - color.a;
    float alpha = 1.0 - smoothstep(width, width + edge, dist);
    
    return half4(1,1,1,alpha);
}
