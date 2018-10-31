
import MetalKit

class ModelMesh: Mesh {
    var meshes: [Any?] = []
    
    init(modelName: String){
        loadModel(modelName: modelName)
    }
    
    func loadModel(modelName: String) {
        guard let assetURL = Bundle.main.url(forResource: modelName, withExtension: "obj") else {
            fatalError("Asset \(modelName) does not exist.")
        }
        let descriptor = MTKModelIOVertexDescriptorFromMetal(Graphics.VertexDescriptors[.Model])
        
        let attributePosition = descriptor.attributes[0] as! MDLVertexAttribute
        attributePosition.name = MDLVertexAttributePosition
        descriptor.attributes[0] = attributePosition
        
        
        let attributeNormal = descriptor.attributes[1] as! MDLVertexAttribute
        attributeNormal.name = MDLVertexAttributeNormal
        descriptor.attributes[1] = attributeNormal
       
        let attributeTexture = descriptor.attributes[2] as! MDLVertexAttribute
        attributeTexture.name = MDLVertexAttributeTextureCoordinate
        descriptor.attributes[2] = attributeTexture
        
        let bufferAllocator = MTKMeshBufferAllocator(device: DarkEngine.Device)
        let asset = MDLAsset(url: assetURL,
                             vertexDescriptor: descriptor,
                             bufferAllocator: bufferAllocator)
        
        do {
            meshes = try MTKMesh.newMeshes(asset: asset,
                                           device: DarkEngine.Device).metalKitMeshes
        } catch {
            print("mesh error")
        }
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        guard let meshes = meshes as? [MTKMesh], meshes.count > 0 else { return }
        for mesh in meshes {
            let vertexBuffer = mesh.vertexBuffers[0]
            renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer,
                                                 offset: vertexBuffer.offset,
                                                 index: 0)
            for submesh in mesh.submeshes {
                renderCommandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                                             indexCount: submesh.indexCount,
                                                             indexType: submesh.indexType,
                                                             indexBuffer: submesh.indexBuffer.buffer,
                                                             indexBufferOffset: submesh.indexBuffer.offset)
            }
        }
    }

}
