
import MetalKit

class ModelGameObject: Node {
    private var _modelMesh: ModelMesh!
    internal var material: Material! = Material()
    
    init(meshType: MeshTypes){
        super.init(name: "Model Game Object")
        _modelMesh = Entities.Meshes[meshType] as? ModelMesh
    }
    
    func setModelTexture(textureType: TextureTypes){
        self.material.useTexture = true
        _modelMesh.setTexture(textureTypes: textureType)
    }

}

extension ModelGameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Model])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 0)
        
        _modelMesh.drawPrimitives(renderCommandEncoder)
    }
}

extension ModelGameObject: Materialable {
    
}


