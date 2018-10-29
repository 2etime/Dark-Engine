
import MetalKit

class Quad_CustomMesh: CustomMesh {
    
    override func createVertices() {
        //Top Right
        addVertex(position: float3( 1, 1,0), normal: float3( 0.0, 1.0, 0.0), textureCoordinate: float2(1,0))
        //Top Left
        addVertex(position: float3(-1, 1,0), normal: float3( 0.0, 1.0, 0.0), textureCoordinate: float2(0,0))
        //Bottom Left
        addVertex(position: float3(-1,-1,0), normal: float3( 0.0, 1.0, 0.0), textureCoordinate: float2(0,1))
        //Top Right
        addVertex(position: float3( 1, 1,0), normal: float3( 0.0, 1.0, 0.0), textureCoordinate: float2(1,0))
        //Bottom Left
        addVertex(position: float3(-1,-1,0), normal: float3( 0.0, 1.0, 0.0), textureCoordinate: float2(0,1))
        //Bottom Right
        addVertex(position: float3( 1,-1,0), normal: float3( 0.0, 1.0, 0.0), textureCoordinate: float2(1,1))
    }
    
}
