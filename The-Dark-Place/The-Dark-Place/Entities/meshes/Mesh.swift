
import MetalKit

protocol Mesh {
    var vertexBuffer: MTLBuffer! { get }
    var vertexCount: Int! { get }
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}
