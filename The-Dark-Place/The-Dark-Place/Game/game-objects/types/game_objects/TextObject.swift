import MetalKit

class TextObject: Node {
    
    private var _useTexture: Bool {
        return textureType != TextureTypes.None
    }
    private var _mesh: Mesh!
    internal var material: Material! = Material()
    internal var texture: MTLTexture!
    internal var textureType: TextureTypes = TextureTypes.None

    var renderPipelineState: MTLRenderPipelineState {
        return Graphics.RenderPipelineStates[.Text]
    }
    
    init(_ fontType: FontTypes) {
        super.init(name: "Text Object")
////        let font = Entities.Fonts[.OperatorFont]
//
//        self.textureType = TextureTypes.OperatorFont
//        if(textureType != TextureTypes.None){
//            self.textureType = textureType
//            self.material.useTexture = true
//        }
    }
}

extension TextObject: Renderable {
    
    func doZPass(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 0)
        renderCommandEncoder.setFragmentTexture(Entities.Textures[textureType], index: 0)
        _mesh.drawPrimitives(renderCommandEncoder)
        
//        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
//        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
    }
    
}

//Material Getters / Setters
extension TextObject: Materialable { }
