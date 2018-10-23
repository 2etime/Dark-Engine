
import MetalKit

class Quad_CustomMesh: CustomMesh {
    
    override func createVertices() {
        addVertex(position: float3( 1, 1, 0), normal: float3(0,1,0))
        addVertex(position: float3(-1, 1, 0), normal: float3(0,1,0))
        addVertex(position: float3(-1,-1, 0), normal: float3(0,1,0))
        
        addVertex(position: float3( 1, 1, 0), normal: float3(0,1,0))
        addVertex(position: float3(-1,-1, 0), normal: float3(0,1,0))
        addVertex(position: float3( 1,-1, 0), normal: float3(0,1,0))
    }
    
}
