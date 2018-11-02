
import MetalKit

protocol Mesh {
    var instanceCount: Int { get set }
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}

extension Mesh {
    mutating func setInstanceCount(_ count: Int) {
        self.instanceCount = count
    }
}
