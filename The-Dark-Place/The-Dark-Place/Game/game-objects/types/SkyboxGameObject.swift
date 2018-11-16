import MetalKit

class SkyboxGameObject: Node {
    private var _mesh: Mesh!
    private var _skyMap: MTLTexture!
    
    init(_ cubeTextureType: CubeTextureTypes) {
        super.init(name: "Skybox")
        _mesh = Entities.Meshes[.CubeForSkybox_Apple]
        _skyMap = Entities.CubeTextures[cubeTextureType]
    }
}

extension SkyboxGameObject: Renderable {
    
    func doZPass(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
    }
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Skybox])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.DontWrite])
        renderCommandEncoder.setFrontFacing(.clockwise)
        renderCommandEncoder.setCullMode(.front)
        
        renderCommandEncoder.setFragmentTexture(_skyMap, index: 0)
        
        _mesh.drawPrimitives(renderCommandEncoder)
        
    }
    
}
