
import MetalKit

class Terrain: Node {
    
    internal var material: Material! = Material()
    var vertices: [Vertex] = []
    var indices: [UInt32] = []
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    
    private var _vertexCount: Int = 0
    
    init(cellCount: Int) {
        super.init(name: "Terrain")
        self._vertexCount = cellCount + 1
        generateTerrain()
        
        vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
        indexBuffer = DarkEngine.Device.makeBuffer(bytes: indices, length: UInt32.stride(indices.count), options: [])
    }
    

    private func generateTerrain() {
        for z in 0..<_vertexCount{
            for x in 0..<_vertexCount{
                //Position
                var pX: Float = Float(x) / Float(Float(_vertexCount) - Float(1))
                pX -= 0.5 //Center on x-axis
                let pY: Float = 0.0
                var pZ: Float = Float(z) / Float(Float(_vertexCount) - Float(1))
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
        
        for gz in 0..<_vertexCount-1{
            for gx in 0..<_vertexCount-1{
                let topLeft: UInt32 = UInt32(gz * _vertexCount + gx)
                let topRight: UInt32 = (topLeft + UInt32(1))
                let bottomLeft: UInt32 = UInt32(((gz + 1) * _vertexCount) + gx)
                let bottomRight: UInt32 = (bottomLeft + UInt32(1))
                indices.append(topLeft)
                indices.append(bottomLeft)
                indices.append(topRight)
                indices.append(topRight)
                indices.append(bottomLeft)
                indices.append(bottomRight)
            }
        }
    }
}

extension Terrain: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.TerrainTextured])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
//        renderCommandEncoder.setTriangleFillMode(.lines)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 0)
        renderCommandEncoder.setFragmentTexture(Entities.Textures[.Grass], index: 0)
        
        renderCommandEncoder.drawIndexedPrimitives(type: .triangle,
                                                   indexCount: indices.count,
                                                   indexType: .uint32,
                                                   indexBuffer: indexBuffer,
                                                   indexBufferOffset: 0)
    }
    
}

//Material Getters / Setters
extension Terrain: Materialable { }
