import MetalKit

protocol sizeable{ }
extension sizeable{
    static var size: Int{ return MemoryLayout<Self>.size }
    static var stride: Int{ return MemoryLayout<Self>.stride }
    static func size(_ count: Int)->Int{ return MemoryLayout<Self>.size * count }
    static func stride(_ count: Int)->Int{ return MemoryLayout<Self>.stride * count }
}

extension float3: sizeable { }

struct Vertex: sizeable {
    var position: float3
    var normal: float3
}

struct Material: sizeable {
    var color: float4 = float4(0.5)  //Initialize to gray
    var ambientIntensity: Float = 0.5
    var diffuseIntensity: Float = 1.0
}

struct ModelConstants: sizeable {
    var modelMatrix = matrix_identity_float4x4
}

struct SceneConstants: sizeable {
    var viewMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
}
