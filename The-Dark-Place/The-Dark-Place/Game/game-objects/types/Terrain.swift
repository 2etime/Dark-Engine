
import MetalKit

class Terrain: Node {
    
    private var material = Material()
    var vertices: [Vertex] = []
    var indices: [UInt32] = []
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    var vertexCount: Int {
        return vertices.count
    }
    var indexCount: Int {
        return indices.count
    }
    
    init(gridX: Float, gridZ: Float) {
        super.init()
        generateTerrain()
        vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices, length: Vertex.stride(vertexCount), options: [])
        indexBuffer = DarkEngine.Device.makeBuffer(bytes: indices, length: UInt32.stride(indexCount), options: [])
    }
    
    let GRID_SIZE: Int = 1
    let VERTEX_COUNT: Int = 6
    private func generateTerrain() {
        for z in 0..<VERTEX_COUNT{
            for x in 0..<VERTEX_COUNT{
                let vX: Float = Float(x) / Float(Float(VERTEX_COUNT) - Float(1)) * Float(GRID_SIZE)
                let vY: Float = 0.0
                let vZ: Float = Float(z) / Float(Float(VERTEX_COUNT) - Float(1)) * Float(GRID_SIZE)
                let position: float3 = float3(vX, vY, vZ)
                vertices.append(Vertex(position: position, normal: float3(0,1,0)))
            }
        }
        
        for gz in 0..<VERTEX_COUNT-1{
            for gx in 0..<VERTEX_COUNT-1{
                let topLeft: UInt32 = UInt32(gz * VERTEX_COUNT + gx)
                let topRight: UInt32 = (topLeft + UInt32(1))
                let bottomLeft: UInt32 = UInt32(((gz + 1) * VERTEX_COUNT) + gx)
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
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        renderCommandEncoder.setTriangleFillMode(.lines)
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 0)
        renderCommandEncoder.drawIndexedPrimitives(type: .triangle,
                                                   indexCount: indexCount,
                                                   indexType: .uint32,
                                                   indexBuffer: indexBuffer,
                                                   indexBufferOffset: 0)
    }
    
}
