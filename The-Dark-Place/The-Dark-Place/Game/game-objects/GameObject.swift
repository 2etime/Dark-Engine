import MetalKit

class GameObject: Node {

    private var _vertexBuffer: MTLBuffer!
    private var _vertices: [Vertex] {
        return [
            Vertex(position: float3( 0, 1, 0)),
            Vertex(position: float3(-1,-1, 0)),
            Vertex(position: float3( 1,-1, 0))
        ]
    }
    
    override init() {
        super.init()
        _vertexBuffer = DarkEngine.Device.makeBuffer(bytes: _vertices, length: MemoryLayout<Vertex>.stride * _vertices.count, options: [])
    }
    
}

extension GameObject: Renderable {
    
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic])
        renderCommandEncoder.setVertexBuffer(_vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: _vertices.count)
    }
    
}
