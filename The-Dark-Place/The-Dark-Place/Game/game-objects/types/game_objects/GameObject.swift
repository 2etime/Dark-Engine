import MetalKit

class GameObject: Node {
    private var _useTexture: Bool {
        return textureType != TextureTypes.None
    }
    private var _mesh: Mesh!
    internal var material: Material! = Material()
    internal var texture: MTLTexture!
    internal var textureType: TextureTypes = TextureTypes.None
    
    private var collisionBox: CollisionBox!

    var renderPipelineState: MTLRenderPipelineState {
        return Graphics.RenderPipelineStates[.Basic]
    }
    
    init(_ meshType: MeshTypes, textureType: TextureTypes = TextureTypes.None) {
        super.init(name: "Game Object")
        self._mesh = Entities.Meshes[meshType]
        if(textureType != TextureTypes.None){
            self.textureType = textureType
            self.material.useTexture = true
        }
        
//        addChild(CollisionBox(_mesh))
    }
    
    func setTexture(textureType: TextureTypes){
        self.material.useTexture = true
        self.texture = Entities.Textures[textureType]
    }
    
    func setTexture(_ texture: MTLTexture){
        self.texture = texture
    }
}

extension GameObject: Renderable {
    
    func doZPass(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
    }
    
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
