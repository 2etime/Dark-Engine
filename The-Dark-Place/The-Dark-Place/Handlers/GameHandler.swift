
import MetalKit

class GameHandler {

    private var _sceneManager: SceneManager!
    
    init() {
        self._sceneManager = SceneManager(.CastleDefense)
    }
    
    public func updateGameView(_ width: Float, _ height: Float) {
        GameView.Width = width
        GameView.Height = height
    }
    
    public  func updateGameTime(_ deltaTime: Float) {
        GameTime.UpdateTime(deltaTime)
    }
    
    public func tickGame(_ drawable: CAMetalDrawable, _ passDescriptor: MTLRenderPassDescriptor){
        
        let commandBuffer = DarkEngine.CommandQueue.makeCommandBuffer()
        
        _sceneManager.tickCurrentScene(commandBuffer!, passDescriptor)
        
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}


