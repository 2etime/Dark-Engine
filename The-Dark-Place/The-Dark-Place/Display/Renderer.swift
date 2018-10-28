import MetalKit

class Renderer: NSObject {
    
    var gameHandler: GameHandler!
    init(_ view: MTKView) {
        gameHandler = GameHandler()
        gameHandler.updateGameView(Float(view.drawableSize.width), Float(view.drawableSize.height))
    }
    
}

extension Renderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        gameHandler.updateGameView(Float(size.width), Float(size.height))
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let passDescriptor = view.currentRenderPassDescriptor  else { return }
        let commandBuffer = DarkEngine.CommandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: passDescriptor)
        
        let deltaTime = 1 / Float(view.preferredFramesPerSecond)
        gameHandler.updateGameTime(deltaTime)
        
        gameHandler.tickGame(renderCommandEncoder!)
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}
