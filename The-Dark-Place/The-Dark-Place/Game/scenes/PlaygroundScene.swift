
import MetalKit

class PlaygroundScene: Scene {

    private var _gameObject = CustomGameObject(.Triangle)
    
    override func buildScene() {
        addChild(_gameObject)
    }
    
}
