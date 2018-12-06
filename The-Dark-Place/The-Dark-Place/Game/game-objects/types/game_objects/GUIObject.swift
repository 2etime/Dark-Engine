import MetalKit
import Foundation

class GUIObject: Node {
    
    private var _mesh: Mesh!
    var projectionMatrix: matrix_float4x4! {
        get {
            let unitsWide: Float = 2
            let unitsTall = GameView.Height / (GameView.Width / unitsWide)
            return matrix_float4x4.orthographic(right: unitsWide / 2.0,
                                                left: -unitsWide / 2.0,
                                                top: unitsTall / 2.0,
                                                bottom: -unitsTall / 2.0,
                                                near: -1.0,
                                                far: 1.0)
        }
        set { }
    }

    override init() {
        super.init()
        self._mesh = Entities.Meshes[.Quad_Custom]
    }

}

extension GUIObject: Renderable {
    func doZPass(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.BasicGui])
        renderCommandEncoder.setVertexBytes(&projectionMatrix, length: matrix_float4x4.stride, index: 1)
        _mesh.drawPrimitives(renderCommandEncoder)
    }
}
