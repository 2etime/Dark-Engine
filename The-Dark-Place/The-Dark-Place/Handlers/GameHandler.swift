
import MetalKit

class GameHandler {

    private static var _sceneManager: SceneManager!
    
    public static func Initialize() {
        self._sceneManager = SceneManager(.Playground)
    }
    
    public static func UpdateGameView(_ aspectRatio: Float) {
        GameView.AspectRatio = aspectRatio
    }
    
    public static func UpdateGameTime(_ deltaTime: Float) {
        GameTime.UpdateTime(deltaTime)
    }
    
    public static func TickGame(_ renderCommandEncoder: MTLRenderCommandEncoder){
        _sceneManager.tickCurrentScene(renderCommandEncoder)
    }
    
}


