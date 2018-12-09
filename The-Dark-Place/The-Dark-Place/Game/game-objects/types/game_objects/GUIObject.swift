import MetalKit
import Foundation

class GUIObject: Node {
    
    private var _mesh: Mesh!

    override init() {
        super.init()
        self.setPositionZ(-1)
        self._mesh = Entities.Meshes[.Quad_Custom]
    }
}

extension GUIObject: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.BasicGui])
        _mesh.drawPrimitives(renderCommandEncoder)
    }
}
