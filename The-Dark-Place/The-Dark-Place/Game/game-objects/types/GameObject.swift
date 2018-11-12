import MetalKit

class GameObject: Node {
    private var _useTexture: Bool {
        return texture != nil
    }
    private var _mesh: Mesh!
    internal var material: Material! = Material()
    internal var texture: MTLTexture! = nil

    var renderPipelineState: MTLRenderPipelineState {
        return Graphics.RenderPipelineStates[.Basic]
    }
    
    init(_ meshType: MeshTypes, textureType: TextureTypes = TextureTypes.None) {
        super.init(name: "Game Object")
        self._mesh = Entities.Meshes[meshType]
        if(textureType != TextureTypes.None){
            self.texture = Entities.Textures[textureType]
            self.material.useTexture = true
        }
    }
    
}

extension GameObject: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Nearest], index: 0)
        renderCommandEncoder.setFragmentTexture(texture, index: 0)
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 0)
        renderCommandEncoder.setCullMode(.none)
        _mesh.drawPrimitives(renderCommandEncoder)
    }
    
}

//Material Getters / Setters
extension GameObject: Materialable { }
