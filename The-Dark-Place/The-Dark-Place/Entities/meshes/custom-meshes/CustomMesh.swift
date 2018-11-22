import MetalKit

public class CustomMesh: Mesh{
    var cubeBoundsMesh: CubeBoundsMesh!

    private var vertices: [Vertex] = []
    var vertexBuffer: MTLBuffer!
    var vertexCount: Int! {
        return vertices.count
    }
    var instanceCount: Int = 1
    var minBounds: float3 = float3(0)
    var maxBounds: float3 = float3(0)
    
    init(){
        createVertices()
        generateBuffers()
    }

    internal func createVertices() {
        //Override with vertices
    }
    
    private func generateBuffers(){
        vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertexCount), options: [])
    }
    
    internal func addVertex(position: float3 = float3(1.0),
                            normal: float3 = float3(0,1,0),
                            textureCoordinate: float2 = float2(0,0)){
        updateBounds(position)
        vertices.append(Vertex(position: position, normal: normal, textureCoordinate: textureCoordinate))
    }
    
    private func updateBounds(_ position: float3){
        if(position.x < minBounds.x){
            minBounds.x = position.x
        }
        if(position.x > maxBounds.x){
            maxBounds.x = position.x
        }
        
        if(position.y < minBounds.y){
            minBounds.y = position.y
        }
        if(position.y > maxBounds.y){
            maxBounds.y = position.y
        }
        
        if(position.z < minBounds.z){
            minBounds.z = position.z
        }
        if(position.z > maxBounds.z){
            maxBounds.z = position.z
        }
        
    }
    
    public func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        renderCommandEncoder.drawPrimitives(type: .triangle,
                                            vertexStart: 0,
                                            vertexCount: vertexCount,
                                            instanceCount: instanceCount)
    }
    
}


