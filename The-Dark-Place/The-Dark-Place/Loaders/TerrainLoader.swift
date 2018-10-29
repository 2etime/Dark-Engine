
import MetalKit

class TerrainLoader {
    public static func GenerateTerrainMesh(cellCount: Int)->Mesh {
        let vertexCount: Int = cellCount + 1
        var vertices: [Vertex] = []
        var indices: [UInt32] = []
        for z in 0..<vertexCount{
            for x in 0..<vertexCount{
                //Position
                var pX: Float = Float(x) / Float(Float(vertexCount) - Float(1))
                pX -= 0.5 //Center on x-axis
                let pY: Float = 0.0
                var pZ: Float = Float(z) / Float(Float(vertexCount) - Float(1))
                pZ -= 0.5 //Center on z-axis
                let position: float3 = float3(pX, pY, pZ)
                
                //TextureCoords
                let tX: Float = Float(x)
                let tZ: Float = Float(z)
                let textureCoordinate: float2  = float2(tX, tZ)
                
                //Normals
                let nX: Float = 0
                let nY: Float = 1
                let nZ: Float = 0
                let normal: float3 = float3(nX, nY, nZ)
                
                vertices.append(Vertex(position: position, normal: normal, textureCoordinate: textureCoordinate))
            }
        }
        
        for gz in 0..<vertexCount-1{
            for gx in 0..<vertexCount-1{
                let topLeft: UInt32 = UInt32(gz * vertexCount + gx)
                let topRight: UInt32 = (topLeft + UInt32(1))
                let bottomLeft: UInt32 = UInt32(((gz + 1) * vertexCount) + gx)
                let bottomRight: UInt32 = (bottomLeft + UInt32(1))
                indices.append(topLeft)
                indices.append(bottomLeft)
                indices.append(topRight)
                indices.append(topRight)
                indices.append(bottomLeft)
                indices.append(bottomRight)
            }
        }
        
        return TerrainMesh(vertices: vertices, indices: indices)
    }
}
