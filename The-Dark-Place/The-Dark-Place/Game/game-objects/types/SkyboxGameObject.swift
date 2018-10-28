import MetalKit

class SkyboxGameObject: Node {
    var meshes: [MTKMesh] = Array()
    var materials: [MTLBuffer] = Array()
    private var _skyMap: MTLTexture!
    private var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    private var renderPipelineState: MTLRenderPipelineState!
    
    init(_ type: CubeTextureTypes) {
        super.init()
        
        createMesh()
        _skyMap = Entities.CubeTextures[type]
    }

    
    private func createMesh(){
        let bufferAllocator = MTKMeshBufferAllocator(device: DarkEngine.Device)
        let mesh = MDLMesh.newBox(withDimensions: float3(1),
                                  segments: vector_uint3(1, 1, 1),
                                  geometryType: MDLGeometryType.triangles,
                                  inwardNormals: true,
                                  allocator: bufferAllocator)
        do {
            try meshes = [MTKMesh.init(mesh: mesh, device: DarkEngine.Device)]
        } catch let error {
            print("Unable to load mesh for new box: \(error)")
        }
    }
}

extension SkyboxGameObject: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Skybox])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.DontWrite])
        renderCommandEncoder.setFrontFacing(.clockwise)
        renderCommandEncoder.setCullMode(.front)
        
        renderCommandEncoder.setFragmentTexture(_skyMap, index: 0)
        
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
    }
    
}
