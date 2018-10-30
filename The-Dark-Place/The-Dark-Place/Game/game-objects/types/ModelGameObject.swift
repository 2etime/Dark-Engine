
import MetalKit

class ModelGameObject: Node {
    private var _modelMesh: ModelMesh!
    private var _material: Material! = Material()
    
    init(meshType: MeshTypes){
        super.init(name: "Model Game Object")
        _modelMesh = Entities.Meshes[.PirateShipModel] as? ModelMesh
    }

}

extension ModelGameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Model])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
        for i in 0..<_modelMesh.meshes.count {
            var mtkMesh: MTKMesh! = nil
            do{
                mtkMesh = try MTKMesh.init(mesh: _modelMesh.meshes[i], device: DarkEngine.Device)
            }catch{
                print(error)
            }
            let vertexBuffer: MTKMeshBuffer = mtkMesh.vertexBuffers.first!
            renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: 0, index: 0)
            
            for j in 0..<mtkMesh.submeshes.count{
                let mtkSubmesh = mtkMesh.submeshes[j]
                renderCommandEncoder.setFragmentBytes(&_material, length: Material.stride, index: 1)
                renderCommandEncoder.drawIndexedPrimitives(type: mtkSubmesh.primitiveType,
                                                           indexCount: mtkSubmesh.indexCount,
                                                           indexType: mtkSubmesh.indexType,
                                                           indexBuffer: mtkSubmesh.indexBuffer.buffer,
                                                           indexBufferOffset: mtkSubmesh.indexBuffer.offset)
            }
        }
    }
}
