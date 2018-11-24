import MetalKit

class CollisionBox: Node {
    private var _cubeBoundsMesh: CubeBoundsMesh!
    
    init(_ mesh: Mesh){
        super.init()
        _cubeBoundsMesh = CubeBoundsMesh(mesh)
    }
    
    func updateOffset(_ offset: float3) {
        self.offset = offset
    }
}

extension CollisionBox: Renderable {
    func doZPass(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Bounding])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        renderCommandEncoder.setCullMode(.none)

        _cubeBoundsMesh.drawPrimitives(renderCommandEncoder)
    }
}
