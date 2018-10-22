import MetalKit

class Renderer: NSObject {
    
    init(_ view: MTKView) {
        GameHandler.UpdateGameView(Float(view.drawableSize.width / view.drawableSize.height))
    }
    
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        GameHandler.UpdateGameView(Float(size.width / size.height))
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let passDescriptor = view.currentRenderPassDescriptor  else { return }
        let commandBuffer = DarkEngine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: passDescriptor)
        
        let deltaTime = 1 / Float(view.preferredFramesPerSecond)
        GameHandler.UpdateGameTime(deltaTime)
        
        GameHandler.TickGame(renderCommandEncoder!)

        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
