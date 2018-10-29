import MetalKit

protocol sizeable{ }
extension sizeable{
    static var size: Int{ return MemoryLayout<Self>.size }
    static var stride: Int{ return MemoryLayout<Self>.stride }
    static func size(_ count: Int)->Int{ return MemoryLayout<Self>.size * count }
    static func stride(_ count: Int)->Int{ return MemoryLayout<Self>.stride * count }
}

extension UInt32: sizeable { }
extension float2: sizeable { }
extension float3: sizeable { }

struct Vertex: sizeable {
    var position: float3
    var normal: float3
    var textureCoordinate: float2
}

struct Material: sizeable {
    var color: float4 = float4(0.5)  //Initialize to gray
    var useTexture: Bool = false
    var ambientIntensity: Float = 0.5
    var diffuseIntensity: Float = 1.0
    var specularIntensity: Float = 0.1 // 0->1
    var shininess: Float = 2.0
}

struct ModelConstants: sizeable {
    var modelMatrix = matrix_identity_float4x4
}

struct SceneConstants: sizeable {
    var viewMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
    var inverseViewMatrix = matrix_identity_float4x4
}

struct LightData: sizeable {
    var color: float3 = float3(1)
    var position: float3 = float3(0)
    var ambientIntensity: Float = 0.5
    var diffuseIntensity: Float = 0.5
 }
