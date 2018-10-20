import MetalKit

class Renderer: NSObject {
 
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

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        //TODO: update when screen is resized.
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let passDescriptor = view.currentRenderPassDescriptor  else { return }
        let commandBuffer = DarkEngine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: passDescriptor)
        
        renderCommandEncoder?.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic])
        renderCommandEncoder?.setVertexBuffer(_vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: _vertices.count)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}