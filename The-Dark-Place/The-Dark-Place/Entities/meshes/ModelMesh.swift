
import MetalKit

class ModelMesh: Mesh {
    var cubeBoundsMesh: CubeBoundsMesh!
    
    var meshes: [Any?] = []
    private var _materials: [Material] = [Material]()
    private var _asset: MDLAsset!
    private var _hasMTLMaterial: Bool = false
    private var _hasTexture: Bool = false
    private var _texture: MTLTexture!
    internal var instanceCount: Int = 1
    internal var maxBounds: float3 = float3(0)
    internal var minBounds: float3 = float3(0)
    
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
        
        
        let vertexDescriptor = MTLVertexDescriptor()
        
        //Position
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].format = .float4
        vertexDescriptor.attributes[0].offset = 0
        
        //Normal
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float3
        vertexDescriptor.attributes[1].offset = float4.stride
        
        //Texture Coordinate
        vertexDescriptor.attributes[2].bufferIndex = 0
        vertexDescriptor.attributes[2].format = .float2
        vertexDescriptor.attributes[2].offset = float3.stride + float4.stride
        
        // Tangents
        vertexDescriptor.attributes[3].bufferIndex = 0
        vertexDescriptor.attributes[3].format = .float3
        vertexDescriptor.attributes[3].offset = float3.stride + float4.stride + float2.stride
        
        // BitTangents
        vertexDescriptor.attributes[4].bufferIndex = 0
        vertexDescriptor.attributes[4].format = .float3
        vertexDescriptor.attributes[4].offset = float3.stride + float4.stride + float2.stride + float3.stride
        
        vertexDescriptor.layouts[0].stride = ModelVertex.stride
        
        let descriptor = MTKModelIOVertexDescriptorFromMetal(vertexDescriptor)
        
        let attributePosition = descriptor.attributes[0] as! MDLVertexAttribute
        attributePosition.name = MDLVertexAttributePosition
        descriptor.attributes[0] = attributePosition
        
        let attributeNormal = descriptor.attributes[1] as! MDLVertexAttribute
        attributeNormal.name = MDLVertexAttributeNormal
        descriptor.attributes[1] = attributeNormal
       
        let attributeTexture = descriptor.attributes[2] as! MDLVertexAttribute
        attributeTexture.name = MDLVertexAttributeTextureCoordinate
        descriptor.attributes[2] = attributeTexture
        
        let attributeTangent = descriptor.attributes[3] as! MDLVertexAttribute
        attributeTangent.name = MDLVertexAttributeTangent
        descriptor.attributes[3] = attributeTangent
        
        let attributeBitTangent = descriptor.attributes[4] as! MDLVertexAttribute
        attributeBitTangent.name = MDLVertexAttributeBitangent
        descriptor.attributes[4] = attributeBitTangent

        let bufferAllocator = MTKMeshBufferAllocator(device: DarkEngine.Device)
        _asset = MDLAsset(url: assetURL,
                          vertexDescriptor: descriptor,
                          bufferAllocator: bufferAllocator)
        
        var mdlMeshes: [MDLMesh] = []
        do {
            mdlMeshes = try MTKMesh.newMeshes(asset: _asset,
                                              device: DarkEngine.Device).modelIOMeshes
        } catch {
            print("mesh error")
        }
        
        //Add Tangents and BitTangents
        for mesh in mdlMeshes {
            mesh.addTangentBasis(forTextureCoordinateAttributeNamed: MDLVertexAttributeTextureCoordinate,
                                    normalAttributeNamed: MDLVertexAttributeNormal,
                                    tangentAttributeNamed: MDLVertexAttributeTangent)
            mesh.addTangentBasis(forTextureCoordinateAttributeNamed: MDLVertexAttributeTextureCoordinate,
                                    tangentAttributeNamed: MDLVertexAttributeTangent,
                                    bitangentAttributeNamed: MDLVertexAttributeBitangent)
            mesh.vertexDescriptor = descriptor
            
            var mtkMesh: MTKMesh!
            do {
                mtkMesh = try MTKMesh(mesh: mesh, device: DarkEngine.Device)
            } catch {
                print("mesh error")
            }
            meshes.append(mtkMesh)
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
            self.minBounds = mdlMesh.boundingBox.minBounds
            self.maxBounds = mdlMesh.boundingBox.maxBounds
            
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
                                                             indexBufferOffset: submesh.indexBuffer.offset,
                                                             instanceCount: instanceCount)
            }
        }
    }

}
