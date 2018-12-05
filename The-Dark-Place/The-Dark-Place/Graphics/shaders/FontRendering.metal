#include <metal_stdlib>
#include "SharedMetal.metal"
using namespace metal;

struct TextData {
    float width;
    float edge;
    float4 color;
};

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
                                   constant TextData &textData [[ buffer(1) ]],
                                   texture2d<float> fontTexture [[ texture(0) ]],
                                   sampler fontSampler [[ sampler(0) ]]) {
    float4 color = fontTexture.sample(fontSampler, rd.textureCoordinate);
    
    float gammaCorrection = 1 / 2.2;
    color = float4(pow(color.r, gammaCorrection), pow(color.g, gammaCorrection), pow(color.b, gammaCorrection), color.a);

    return half4(color.r, color.g, color.b, color.a);
}

fragment half4 field_distance_font_fragment(RasterizerData rd [[ stage_in ]],
                                   constant TextData &textData [[ buffer(1) ]],
                                   texture2d<float> fontAtlas [[ texture(0) ]],
                                   sampler fontSampler [[ sampler(0) ]]) {
    float4 color = textData.color;
    
    float4 fontAtlasColor =  fontAtlas.sample(fontSampler, rd.textureCoordinate);
    float gammaCorrection = 1 / 2.2;
    fontAtlasColor = float4(pow(fontAtlasColor.r, gammaCorrection),
                            pow(fontAtlasColor.g, gammaCorrection),
                            pow(fontAtlasColor.b, gammaCorrection),
                            fontAtlasColor.a);
    
    
    float dist = 1.0 - fontAtlasColor.a;
    float alpha = 1.0 - smoothstep(textData.width, textData.width + textData.edge, dist);
    
    return half4(color.r, color.g, color.b, alpha);
}
