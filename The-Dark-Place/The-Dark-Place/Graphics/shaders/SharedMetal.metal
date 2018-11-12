#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[ attribute(0) ]];
    float3 normal [[ attribute(1) ]];
    float2 textureCoordinate [[ attribute(2) ]];
};

struct ModelConstants {
    float4x4 modelMatrix;
};

struct SceneConstants {
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
    float4x4 inverseViewMatrix;
};

struct Material {
    float4 color;
    bool useTexture;
    float ambientIntensity;
    float diffuseIntensity;
    float specularIntensity;
    float shininess;
};

struct RasterizerData {
    float4 position [[ position ]];
    float3 surfaceNormal;
    float2 textureCoordinate;
    float3 worldPosition;
    float3 toCameraVector;
};

struct LightData {
    float3 color;
    float3 position;
    float ambientIntensity;
    float diffuseIntensity;
    float3 attenuation;
};
