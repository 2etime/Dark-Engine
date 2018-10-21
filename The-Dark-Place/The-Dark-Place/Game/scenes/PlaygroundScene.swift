
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Triangle()
    override func buildScene() {
        _object.setColor(Colors.random)
        _object.setPositionX(-0.5)
        addChild(_object)
    }
    
    override func onUpdate(_ deltaTime: Float) {
        _object.moveX(deltaTime)
    }
    
}
