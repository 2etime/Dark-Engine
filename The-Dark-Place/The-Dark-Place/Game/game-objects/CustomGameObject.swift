import MetalKit

class CustomGameObject: Node {
    
    private var _mesh: CustomMesh!
    init(_ customMeshType: CustomMeshTypes) {
        super.init()
        self._mesh = Entities.CustomMeshes[.Triangle]
    }
    
}

extension CustomGameObject: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic])
        
        _mesh.drawPrimitives(renderCommandEncoder)
    }
    
}
