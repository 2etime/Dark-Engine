
import MetalKit

class ModelMesh: Mesh {
    var meshes: [Any?] = []
    private var _materials: [Material] = [Material]()
    private var _asset: MDLAsset!
    private var _hasMTLMaterial: Bool = false
    private var _hasTexture: Bool = false
    private var _texture: MTLTexture!
    
    init(modelName: String){
        loadModel(modelName: modelName)
        generateMaterial()
    }
    
    func setTexture(textureTypes: TextureTypes){
        self._hasTexture = true
        self._texture = Entities.Textures[textureTypes]
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
//                let ambient = float3(0.5)
                let color = mdlSubmeshes![j].material?.properties(with: MDLMaterialSemantic.baseColor).first?.float3Value
                let specular = mdlSubmeshes![j].material?.properties(with: MDLMaterialSemantic.specular).first?.float3Value
                if(color?.x != 0 || color?.y != 0 || color?.z != 0){
                    _hasMTLMaterial = true
                }
                var material = Material()
                material.color = float4(color!.x, color!.y, color!.z, 1.0)
                material.specularIntensity = specular!.x
                _materials.append(material)
            }
        }
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
                if(_hasTexture){
                    renderCommandEncoder.setFragmentTexture(_texture, index: 0)
                }else if(_hasMTLMaterial){
                    renderCommandEncoder.setFragmentBytes(&_materials[i], length: Material.stride, index: 0)
                }
                renderCommandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                                             indexCount: submesh.indexCount,
                                                             indexType: submesh.indexType,
                                                             indexBuffer: submesh.indexBuffer.buffer,
                                                             indexBufferOffset: submesh.indexBuffer.offset)
            }
        }
    }

}
