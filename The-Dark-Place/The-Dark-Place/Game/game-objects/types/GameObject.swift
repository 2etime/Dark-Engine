import MetalKit

class GameObject: Node {
    private var _mesh: Mesh!
    internal var material: Material! = Material()
    internal var texture: MTLTexture!
    
    var renderPipelineState: MTLRenderPipelineState {
        var rps: MTLRenderPipelineState
        if(texture != nil){
            rps = Graphics.RenderPipelineStates[.Basic]
        }else {
            rps = Graphics.RenderPipelineStates[.Basic]
        }
        return rps
    }
    
    init(_ meshType: MeshTypes) {
        super.init(name: "Game Object")
        self._mesh = Entities.Meshes[meshType]
    }
    
}

extension GameObject: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 0)
        _mesh.drawPrimitives(renderCommandEncoder)
    }
    
}

//Material Getters / Setters
extension GameObject: Materialable { }
