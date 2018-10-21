
import MetalKit

class GameHandler {

    private static var _sceneManager: SceneManager!
    
    public static func Initialize() {
        self._sceneManager = SceneManager(.Playground)
    }
    
    public static func TickGame(_ renderCommandEncoder: MTLRenderCommandEncoder, _ deltaTime: Float){
        
        _sceneManager.tickCurrentScene(renderCommandEncoder, deltaTime)
        
    }
    
}
