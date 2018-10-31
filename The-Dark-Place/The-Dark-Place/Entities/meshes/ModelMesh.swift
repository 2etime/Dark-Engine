
import MetalKit

class ModelMesh: Mesh {
    var meshes: [Any?] = []
    private var _materials: [Material] = [Material]()
    private var _asset: MDLAsset!
    
    init(modelName: String){
        loadModel(modelName: modelName)
        generateMaterial()
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
        _asset = MDLAsset(url: assetURL,
                             vertexDescriptor: descriptor,
                             bufferAllocator: bufferAllocator)
        
        do {
            meshes = try MTKMesh.newMeshes(asset: _asset,
                                           device: DarkEngine.Device).metalKitMeshes
        } catch {
            print("mesh error")
        }
    }
    
    private func generateMaterial(){
        var mdlMeshes: [MDLMesh] = []
        do {
            mdlMeshes = try MTKMesh.newMeshes(asset: _asset,
                                              device: DarkEngine.Device).modelIOMeshes
        } catch {
            print("mesh error")
        }
        
        
        for i in 0..<mdlMeshes.count {
            let mdlMesh: MDLMesh! = mdlMeshes[i]
            let count: Int = mdlMesh!.submeshes?.count ?? 0
            
            for j in 0..<count{
                let mdlSubmeshes = mdlMesh.submeshes as? [MDLSubmesh]
                let ambient = float3(0.5)
                let color = mdlSubmeshes![j].material?.property(with: MDLMaterialSemantic.baseColor)?.color
                var material = Material()
                material.color = getColor(color: color!)
                _materials.append(material)
            }
        }
    }
    
    func getColor(color: CGColor)->float4 {
        let components = color.components
        let r = components?[0]
        let g = components?[1]
        let b = components?[2]
        return float4(Float(r ?? 0),Float(g ?? 0),Float(b ?? 0), 1)
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        guard let meshes = meshes as? [MTKMesh], meshes.count > 0 else { return }
        for mesh in meshes {
            let vertexBuffer = mesh.vertexBuffers[0]
            renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer,
                                                 offset: vertexBuffer.offset,
                                                 index: 0)
            for  i in 0..<mesh.submeshes.count {
                let submesh = mesh.submeshes[i]
                renderCommandEncoder.setFragmentBytes(&_materials[i], length: Material.stride, index: 0)
                renderCommandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                                             indexCount: submesh.indexCount,
                                                             indexType: submesh.indexType,
                                                             indexBuffer: submesh.indexBuffer.buffer,
                                                             indexBufferOffset: submesh.indexBuffer.offset)
            }
        }
    }

}
