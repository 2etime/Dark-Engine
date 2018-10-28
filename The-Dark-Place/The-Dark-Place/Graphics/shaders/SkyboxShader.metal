#include "SharedMetal.metal"
using namespace metal;

struct SkyboxVertex {
    float4 position [[ attribute(0) ]];
    float2 textureCoordinate [[ attribute(2) ]];
};

struct SkyboxRasterizerData {
    float4 position [[ position ]];
    float3 textureCoordinate;
};

vertex SkyboxRasterizerData skybox_vertex(SkyboxVertex vertexIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]) {
    SkyboxRasterizerData rd;
    float4x4 viewMatrix = sceneConstants.viewMatrix * modelConstants.modelMatrix;
    viewMatrix[3][0] = 0;
    viewMatrix[3][1] = 0;
    viewMatrix[3][2] = 0;
    rd.position = sceneConstants.projectionMatrix * viewMatrix * vertexIn.position;
    rd.textureCoordinate = vertexIn.position.xyz;
    return rd;
}

fragment half4 skybox_fragment(SkyboxRasterizerData rd [[ stage_in ]],
                               texturecube<float> skyboxTexture [[ texture(0) ]]){
    
    
    constexpr sampler linearSampler(mip_filter::linear,
                                    mag_filter::linear,
                                    min_filter::linear);
    
    float4 color = skyboxTexture.sample(linearSampler, float3(rd.textureCoordinate.x, rd.textureCoordinate.y, -rd.textureCoordinate.z));
    
    return half4(color.r, color.g, color.b, color.a);
}
