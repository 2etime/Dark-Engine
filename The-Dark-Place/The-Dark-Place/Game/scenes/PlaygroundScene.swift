
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Triangle()

    override func buildScene() {
        
        _object.setColor(Colors.random)
        
        addChild(_object)
    }
    
}
