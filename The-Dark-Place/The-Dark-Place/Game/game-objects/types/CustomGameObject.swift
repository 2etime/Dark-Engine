import MetalKit

class CustomGameObject: Node {
    
    private var _material = Material()
    private var _mesh: CustomMesh!
    
    init(_ customMeshType: CustomMeshTypes) {
        super.init()
        self._mesh = Entities.CustomMeshes[.Triangle]
    }
    
}

extension CustomGameObject: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic])
        
        renderCommandEncoder.setFragmentBytes(&_material, length: Material.stride, index: 0)
        
        _mesh.drawPrimitives(renderCommandEncoder)
    }
    
}

//Material Getters / Setters
extension CustomGameObject {
    func setColor(_ colorValue: float4){ self._material.color = colorValue }
    func getColor()->float4{ return self._material.color }
}