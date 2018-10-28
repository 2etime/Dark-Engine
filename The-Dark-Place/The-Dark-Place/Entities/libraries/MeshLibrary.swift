
import MetalKit

public enum MeshTypes {
    case Triangle_Custom
    case Cube_Custom
    case Quad_Custom
    
    case CubeForSkybox_Apple
}

class MeshLibrary: Library<MeshTypes, Mesh> {

    private var library: [MeshTypes : Mesh] = [:]
    
    override func fillLibrary() {
        //Custom Meshes
        library.updateValue(Triangle_CustomMesh(), forKey: .Triangle_Custom)
        library.updateValue(Cube_CustomMesh(), forKey: .Cube_Custom)
        library.updateValue(Quad_CustomMesh(), forKey: .Quad_Custom)
        
        //Apple Meshes
        library.updateValue(AppleMesh(.CubeForSkybox_Apple), forKey: .CubeForSkybox_Apple)
    }
    
    override subscript(_ type: MeshTypes) -> Mesh {
        return (library[type])!
    }
    
}

public class AppleMesh: Mesh{
    var vertexBuffer: MTLBuffer!
    var vertexCount: Int! = 0
    
    var meshes: [MTKMesh] = Array()
    
    init(_ meshType: MeshTypes){
        generateMesh(meshType)
    }
    
    private func generateMesh(_ meshType: MeshTypes){
        let bufferAllocator = MTKMeshBufferAllocator(device: DarkEngine.Device)
        var mesh: MDLMesh!
        switch meshType {
        case .CubeForSkybox_Apple:
            mesh = MDLMesh.newBox(withDimensions: float3(1),
                                  segments: vector_uint3(1, 1, 1),
                                  geometryType: MDLGeometryType.triangles,
                                  inwardNormals: true,
                                  allocator: bufferAllocator)
        default:
            break;
        }
        
        do {
            try meshes = [MTKMesh.init(mesh: mesh, device: DarkEngine.Device)]
        } catch let error {
            print("Unable to load mesh for new box: \(error)")
        }
    }
    
    public func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.pushDebugGroup("Drawing Mesh Primitives")
        for mesh in meshes {
            let vertexBuffer = mesh.vertexBuffers[0]
            renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, index: 0)
            
            for submesh in mesh.submeshes {
                renderCommandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                                           indexCount: submesh.indexCount,
                                                           indexType: submesh.indexType,
                                                           indexBuffer: submesh.indexBuffer.buffer,
                                                           indexBufferOffset: submesh.indexBuffer.offset)
            }
        }
        renderCommandEncoder.popDebugGroup()
    }
    
}






