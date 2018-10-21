
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Triangle()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    override func buildScene() {
        _object.setColor(Colors.random)
        addChild(_object)
        _object.setPositionZ(-5)
    }
    
    override func onUpdate() {
        
    }
    
}
