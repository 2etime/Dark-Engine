import MetalKit

class Renderer: NSObject {
    var gameObject = GameObject()
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        //TODO: update when screen is resized.
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let passDescriptor = view.currentRenderPassDescriptor  else { return }
        let commandBuffer = DarkEngine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: passDescriptor)
        
        gameObject.render(renderCommandEncoder!)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
