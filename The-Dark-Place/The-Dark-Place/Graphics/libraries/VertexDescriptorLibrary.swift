import MetalKit

enum VertexDescriptorTypes {
    case Basic
    case MDLMesh
    case Model
}

class VertexDescriptorLibrary: Library<VertexDescriptorTypes, MTLVertexDescriptor> {
    
    private var library: [VertexDescriptorTypes : VertexDescriptor] = [:]
    
    override func fillLibrary() {
        library.updateValue(Basic_VertexDescriptor(), forKey: .Basic)
        library.updateValue(MDLMesh_VertexDescriptor(), forKey: .MDLMesh)
        library.updateValue(Model_VertexDescriptor(), forKey: .Model)
    }
    
    override subscript(_ type: VertexDescriptorTypes) -> MTLVertexDescriptor {
        return (library[type]?.vertexDescriptor!)!
    }
    
}

protocol VertexDescriptor {
    var name: String { get }
    var vertexDescriptor: MTLVertexDescriptor! { get }
}

class Basic_VertexDescriptor: VertexDescriptor {
    var name: String = "Basic Vertex Descriptor"
    var vertexDescriptor: MTLVertexDescriptor!
    
    init() {
        vertexDescriptor = MTLVertexDescriptor()
        
        //Position
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        
        //Normal
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float3
        vertexDescriptor.attributes[1].offset = float3.stride
        
        //Texture Coordinate
        vertexDescriptor.attributes[2].bufferIndex = 0
        vertexDescriptor.attributes[2].format = .float2
        vertexDescriptor.attributes[2].offset = float3.stride + float3.stride
        
        vertexDescriptor.layouts[0].stride = Vertex.stride
    }
}

class Model_VertexDescriptor: VertexDescriptor {
    var name: String = "Model Vertex Descriptor"
    var vertexDescriptor: MTLVertexDescriptor!
    
    init() {
        vertexDescriptor = MTLVertexDescriptor()
        
        //Position
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        
        //Color
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = 0
        
        //Normal
        vertexDescriptor.attributes[2].bufferIndex = 0
        vertexDescriptor.attributes[2].format = .float3
        vertexDescriptor.attributes[2].offset = float3.stride + float4.stride
        
        //Texture Coordinate
        vertexDescriptor.attributes[3].bufferIndex = 0
        vertexDescriptor.attributes[3].format = .float2
        vertexDescriptor.attributes[3].offset = float3.stride + float4.stride + float3.stride
        
        vertexDescriptor.layouts[0].stride = ModelVertex.stride
    }
}

class MDLMesh_VertexDescriptor: VertexDescriptor {
    var name: String = "MDLMesh Vertex Descriptor"
    var vertexDescriptor: MTLVertexDescriptor!
    
    init() {
        let bufferAllocator = MTKMeshBufferAllocator(device: DarkEngine.Device)
        let mesh = MDLMesh.newBox(withDimensions: float3(1),
                                  segments: vector_uint3(1, 1, 1),
                                  geometryType: MDLGeometryType.triangles,
                                  inwardNormals: false,
                                  allocator: bufferAllocator)
        vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mesh.vertexDescriptor)
    }
}
