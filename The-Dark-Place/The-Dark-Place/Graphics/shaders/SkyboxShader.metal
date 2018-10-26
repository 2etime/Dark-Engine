 #include <metal_stdlib>
#include "SharedMetal.metal"
using namespace metal;

struct SkyboxVertex {
    float4 position [[ attribute(0) ]];
    float3 normal [[ attribute(1) ]];
};

struct SkyboxRasterizerData {
    float4 position [[ position ]];
    float3 textureCoordinate;
};

vertex SkyboxRasterizerData skybox_vertex(SkyboxVertex vertexIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(0) ]],
                                          constant ModelConstants &modelConstants [[ buffer(1) ]]) {
    SkyboxRasterizerData rd;
    
    
    return rd;
}

fragment half4 skybox_fragment(SkyboxRasterizerData rd [[ stage_in ]],
                               texturecube<float> skyboxTexture [[ texture(0) ]]){
    
    
    constexpr sampler linearSampler(mip_filter::linear,
                            mag_filter::linear,
                            min_filter::linear);
    
    float4 color = skyboxTexture.sample(linearSampler, rd.textureCoordinate);
    
    return half4(color.r, color.g, color.b, color.a);
}
