import MetalKit

class GameObject: Node {
    private var _mesh: Mesh!
    private var _material = Material()
    
    var renderPipelineState: MTLRenderPipelineState {
        return Graphics.RenderPipelineStates[.Basic]
    }
    
    init(_ meshType: MeshTypes) {
        super.init()
        self._mesh = Entities.Meshes[meshType]
    }
    
}

extension GameObject: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.pushDebugGroup("Drawing Game Object")
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setFragmentBytes(&_material, length: Material.stride, index: 0)
        _mesh.drawPrimitives(renderCommandEncoder)
        renderCommandEncoder.popDebugGroup()
    }
    
}

//Material Getters / Setters
extension GameObject {
    func setColor(_ colorValue: float4){ self._material.color = colorValue }
    func getColor()->float4{ return self._material.color }
    
    func setAmbientIntensity(_ ambientValue: Float){ self._material.ambientIntensity = ambientValue }
    func getAmbientIntensity()->Float { return self._material.ambientIntensity }
    
}