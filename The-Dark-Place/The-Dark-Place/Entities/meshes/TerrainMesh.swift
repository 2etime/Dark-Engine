
import MetalKit

class TerrainMesh: Mesh {
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    var vertexCount: Int!
    var indexCount: Int!
    
    init(vertices: [Vertex], indices: [UInt32]){
        self.vertexCount = vertices.count
        self.indexCount = indices.count
        vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
        indexBuffer = DarkEngine.Device.makeBuffer(bytes: indices, length: UInt32.stride(indices.count), options: [])
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawIndexedPrimitives(type: .triangle,
                                                   indexCount: indexCount,
                                                   indexType: .uint32,
                                                   indexBuffer: indexBuffer,
                                                   indexBufferOffset: 0)
    }
}
