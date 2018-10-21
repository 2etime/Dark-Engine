import MetalKit

public class CustomMesh: Mesh{
    
    private var vertices: [Vertex] = []
    var vertexBuffer: MTLBuffer!
    var vertexCount: Int! {
        return vertices.count
    }
    
    init(){
        createVertices()
        generateBuffers()
    }

    internal func createVertices() {
        //Override with vertices
    }
    
    private func generateBuffers(){
        vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices, length: MemoryLayout<Vertex>.stride * vertexCount, options: [])
    }
    
    internal func addVertex(position: float3 = float3(1.0)){
        vertices.append(Vertex(position: position))
    }
    
    public func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
    }
    
}


