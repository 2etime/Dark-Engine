
import MetalKit

class ModelGameObject: Node {
    private var _modelMesh: ModelMesh!
    private var _material: Material! = Material()
    
    init(meshType: MeshTypes){
        super.init(name: "Model Game Object")
        _modelMesh = Entities.Meshes[meshType] as? ModelMesh
    }

}

extension ModelGameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Model])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        

        _modelMesh.drawPrimitives(renderCommandEncoder)
    }
}


