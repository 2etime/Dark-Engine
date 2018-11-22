
import MetalKit

protocol Mesh {
    var instanceCount: Int { get set }
    var minBounds: float3 { get }
    var maxBounds: float3 { get }
    var cubeBoundsMesh: CubeBoundsMesh! { get }
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}

extension Mesh {
    mutating func setInstanceCount(_ count: Int) {
        self.instanceCount = count
    }
}
