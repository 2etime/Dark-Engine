import MetalKit

protocol Renderable {
    func doZPass(_ renderCommandEncoder: MTLRenderCommandEncoder)
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder)
}
