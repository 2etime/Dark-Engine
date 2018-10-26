
import MetalKit

class GameHandler {

    private var _sceneManager: SceneManager!
    
    init() {
        self._sceneManager = SceneManager(.Playground)
    }
    
    public func updateGameView(_ width: Float, _ height: Float) {
        GameView.Width = width
        GameView.Height = height
    }
    
    public  func updateGameTime(_ deltaTime: Float) {
        GameTime.UpdateTime(deltaTime)
    }
    
    public func tickGame(_ renderCommandEncoder: MTLRenderCommandEncoder){
        _sceneManager.tickCurrentScene(renderCommandEncoder)
    }
    
}


