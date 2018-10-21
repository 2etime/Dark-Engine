
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Triangle()
    override func buildScene() {
        _object.setColor(Colors.random)
        addChild(_object)
    }
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    override func onUpdate() {
        _object.setPositionX(cos(GameTime.TotalGameTime))
    }
    
}
