import MetalKit

class Renderer: NSObject {
    private var _vertexDescriptor: MTLVertexDescriptor {
        let vertexDescriptor = MTLVertexDescriptor()
        
        //Position
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        
        return vertexDescriptor
    }
    
    private var _renderPipelineState: MTLRenderPipelineState!
    private var _renderPipelineDescriptor: MTLRenderPipelineDescriptor {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        
        let library = DarkEngine.Device.makeDefaultLibrary()
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.vertexDescriptor = _vertexDescriptor
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        return renderPipelineDescriptor
    }
    
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
        
        do {
            _renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: _renderPipelineDescriptor)
        } catch {
            print(error)
        }
        
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
        
        renderCommandEncoder?.setRenderPipelineState(_renderPipelineState)
        renderCommandEncoder?.setVertexBuffer(_vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: _vertices.count)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
