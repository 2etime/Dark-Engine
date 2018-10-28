
import MetalKit

class Terrain: Node {
    
    private var _material = Material()
    var vertices: [Vertex] = []
    var indices: [UInt32] = []
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    
    private var _gridSize: Int = 0
    private var _vertexCount: Int = 0
    
    init(gridSize: Int, cellCount: Int) {
        super.init(name: "Terrain")
        self._vertexCount = cellCount + 1
        self._gridSize = gridSize
        generateTerrain()
        
        //Center the terrain
        self.moveX(-(Float(gridSize) / 2.0))
        self.moveZ(-(Float(gridSize) / 2.0))
        
        vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertices.count), options: [])
        indexBuffer = DarkEngine.Device.makeBuffer(bytes: indices, length: UInt32.stride(indices.count), options: [])
    }
    

    private func generateTerrain() {
        for z in 0..<_vertexCount{
            for x in 0..<_vertexCount{
                //Position
                let pX: Float = Float(x) / Float(Float(_vertexCount) - Float(1)) * Float(_gridSize)
                let pY: Float = 0.0
                let pZ: Float = Float(z) / Float(Float(_vertexCount) - Float(1)) * Float(_gridSize)
                let position: float3 = float3(pX, pY, pZ)
                
                //TextureCoords
                let tX: Float = fmod(Float(x), 2.0)
                let tZ: Float = fmod(Float(z), 2.0)
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
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        renderCommandEncoder.setFragmentBytes(&_material, length: Material.stride, index: 0)
        
        renderCommandEncoder.drawIndexedPrimitives(type: .triangle,
                                                   indexCount: indices.count,
                                                   indexType: .uint32,
                                                   indexBuffer: indexBuffer,
                                                   indexBufferOffset: 0)
    }
    
}

//Material Getters / Setters
extension Terrain {
    func setColor(_ colorValue: float4){ self._material.color = colorValue }
    func getColor()->float4{ return self._material.color }
    
    func setAmbientIntensity(_ ambientValue: Float){ self._material.ambientIntensity = ambientValue }
    func getAmbientIntensity()->Float { return self._material.ambientIntensity }
}
