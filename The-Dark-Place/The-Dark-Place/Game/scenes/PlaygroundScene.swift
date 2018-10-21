
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Triangle()
    override func buildScene() {
        _object.setColor(Colors.random)
        addChild(_object)
    }
    
    override func onUpdate() {
        _object.setRotationZ(cos(GameTime.TotalGameTime))
        _object.setPositionX(cos(GameTime.TotalGameTime))
        _object.setScale(cos(GameTime.TotalGameTime))
    }
    
}
