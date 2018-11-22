import MetalKit

class CubeBoundsMesh {
    var cubeBoundsMesh: CubeBoundsMesh! //Do not use this
    
    private var vertices: [Vertex] = []
    private var vertexBuffer: MTLBuffer!
    private var minBounds: float3 = float3(0,0,-0.1)
    private var maxBounds: float3 = float3(0,0,0.1)
    
    
    init(_ mesh: Mesh) {
        self.minBounds = mesh.minBounds
        self.maxBounds = mesh.maxBounds
//        minBounds.z = -1
//        maxBounds.z = 1
        generateVertices()
        generateBuffers()
    }
    
    internal func addVertex(position: float3 = float3(1.0),
                            normal: float3 = float3(0,1,0),
                            textureCoordinate: float2 = float2(0,0)){
        vertices.append(Vertex(position: position, normal: normal, textureCoordinate: textureCoordinate))
    }
    
    func generateVertices(){
        //Left
        addVertex(position: float3( minBounds.x, minBounds.y, minBounds.z), normal: float3(-1.0, 0.0, 0.0), textureCoordinate: float2(0,1)) // left bottom  back
        addVertex(position: float3( minBounds.x, minBounds.y, maxBounds.z), normal: float3(-1.0, 0.0, 0.0), textureCoordinate: float2(1,1)) // left bottom  front
        addVertex(position: float3( minBounds.x, maxBounds.y, maxBounds.z), normal: float3(-1.0, 0.0, 0.0), textureCoordinate: float2(1,0)) // left top     front
        addVertex(position: float3( minBounds.x, minBounds.y, minBounds.z), normal: float3(-1.0, 0.0, 0.0), textureCoordinate: float2(0,1)) // left bottom  back
        addVertex(position: float3( minBounds.x, maxBounds.y, maxBounds.z), normal: float3(-1.0, 0.0, 0.0), textureCoordinate: float2(1,0)) // left top     front
        addVertex(position: float3( minBounds.x, maxBounds.y, minBounds.z), normal: float3(-1.0, 0.0, 0.0), textureCoordinate: float2(0,0)) // left top     back
        
        //RIGHT
        addVertex(position: float3(maxBounds.x, maxBounds.y, maxBounds.z), normal: float3( 1.0, 0.0, 0.0), textureCoordinate: float2(0,0)) // right top     front
        addVertex(position: float3(maxBounds.x, minBounds.y, minBounds.z), normal: float3( 1.0, 0.0, 0.0), textureCoordinate: float2(1,1)) // right bottom  back
        addVertex(position: float3(maxBounds.x, maxBounds.y, minBounds.z), normal: float3( 1.0, 0.0, 0.0), textureCoordinate: float2(1,0)) // right top     back
        addVertex(position: float3(maxBounds.x, minBounds.y, minBounds.z), normal: float3( 1.0, 0.0, 0.0), textureCoordinate: float2(1,1)) // right bottom  back
        addVertex(position: float3(maxBounds.x, maxBounds.y, maxBounds.z), normal: float3( 1.0, 0.0, 0.0), textureCoordinate: float2(0,0)) // right top     front
        addVertex(position: float3(maxBounds.x, minBounds.y, maxBounds.z), normal: float3( 1.0, 0.0, 0.0), textureCoordinate: float2(0,1)) // right bottom  front
        
        //TOP
        addVertex(position: float3(maxBounds.x, maxBounds.y, maxBounds.z), normal: float3(0.0, 1.0, 0.0), textureCoordinate: float2(1,0)) // right top      front
        addVertex(position: float3(maxBounds.x, maxBounds.y, minBounds.z), normal: float3(0.0, 1.0, 0.0), textureCoordinate: float2(1,1)) // right top      back
        addVertex(position: float3(minBounds.x, maxBounds.y, minBounds.z), normal: float3(0.0, 1.0, 0.0), textureCoordinate: float2(0,1)) // left  top      back
        addVertex(position: float3(maxBounds.x, maxBounds.y, maxBounds.z), normal: float3(0.0, 1.0, 0.0), textureCoordinate: float2(1,0)) // right top      front
        addVertex(position: float3(minBounds.x, maxBounds.y, minBounds.z), normal: float3(0.0, 1.0, 0.0), textureCoordinate: float2(0,1)) // left  top      back
        addVertex(position: float3(minBounds.x, maxBounds.y, maxBounds.z), normal: float3(0.0, 1.0, 0.0), textureCoordinate: float2(0,0)) // left  top      front
        
        //BOTTOM
        addVertex(position: float3(maxBounds.x, minBounds.y, maxBounds.z), normal: float3(0.0,-1.0, 0.0), textureCoordinate: float2(1,0)) // right bottom   front
        addVertex(position: float3(minBounds.x, minBounds.y, minBounds.z), normal: float3(0.0,-1.0, 0.0), textureCoordinate: float2(0,1)) // left  bottom   back
        addVertex(position: float3(maxBounds.x, minBounds.y, minBounds.z), normal: float3(0.0,-1.0, 0.0), textureCoordinate: float2(1,1)) // right bottom   back
        addVertex(position: float3(maxBounds.x, minBounds.y, maxBounds.z), normal: float3(0.0,-1.0, 0.0), textureCoordinate: float2(1,0)) // right bottom   front
        addVertex(position: float3(minBounds.x, minBounds.y, maxBounds.z), normal: float3(0.0,-1.0, 0.0), textureCoordinate: float2(0,0)) // left  bottom   front
        addVertex(position: float3(minBounds.x, minBounds.y, minBounds.z), normal: float3(0.0,-1.0, 0.0), textureCoordinate: float2(0,1)) // left  bottom   back
        
        //BACK
        addVertex(position: float3(maxBounds.y, maxBounds.y, minBounds.z), normal: float3(0.0, 0.0,-1.0), textureCoordinate: float2(1,0)) // right top      back
        addVertex(position: float3(minBounds.x, minBounds.y, minBounds.z), normal: float3(0.0, 0.0,-1.0), textureCoordinate: float2(0,1)) // left  bottom   back
        addVertex(position: float3(minBounds.x, maxBounds.y, minBounds.z), normal: float3(0.0, 0.0,-1.0), textureCoordinate: float2(0,0)) // left  top      back
        addVertex(position: float3(maxBounds.x, maxBounds.y, minBounds.z), normal: float3(0.0, 0.0,-1.0), textureCoordinate: float2(1,0)) // right top      back
        addVertex(position: float3(maxBounds.x, minBounds.y, minBounds.z), normal: float3(0.0, 0.0,-1.0), textureCoordinate: float2(1,1)) // right bottom   back
        addVertex(position: float3(minBounds.x, minBounds.y, minBounds.z), normal: float3(0.0, 0.0,-1.0), textureCoordinate: float2(0,1)) // left  bottom   back
        
        //FRONT
        addVertex(position: float3(minBounds.x, maxBounds.y, maxBounds.z), normal: float3(0.0, 0.0, 1.0), textureCoordinate: float2(0,0)) // left  top      front
        addVertex(position: float3(minBounds.x, minBounds.y, maxBounds.z), normal: float3(0.0, 0.0, 1.0), textureCoordinate: float2(0,1)) // left  bottom   front
        addVertex(position: float3(maxBounds.x, minBounds.y, maxBounds.z), normal: float3(0.0, 0.0, 1.0), textureCoordinate: float2(1,1)) // right bottom   front
        
        addVertex(position: float3(maxBounds.x, maxBounds.y, maxBounds.z), normal: float3(0.0, 0.0, 1.0), textureCoordinate: float2(1,0)) // right top      front
        addVertex(position: float3(minBounds.x, maxBounds.y, maxBounds.z), normal: float3(0.0, 0.0, 1.0), textureCoordinate: float2(0,0)) // left  top      front
        addVertex(position: float3(maxBounds.x, minBounds.y, maxBounds.z), normal: float3(0.0, 0.0, 1.0), textureCoordinate: float2(1,1)) // right bottom   front
    }
    
    func generateBuffers(){
        vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
    }
    
    func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {

        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
    
    
}
