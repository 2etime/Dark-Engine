import MetalKit

class TextGUI: Node {
    
    private var textMesh: TextMesh!
    
    init(_ textMeshType: TextMeshTypes) {
        super.init()
        self.textMesh = Entities.Text?[textMeshType]
    }
    
}

extension TextGUI: Renderable {
    func doZPass(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Text])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
        textMesh.drawPrimitives(renderCommandEncoder)
    }
}
