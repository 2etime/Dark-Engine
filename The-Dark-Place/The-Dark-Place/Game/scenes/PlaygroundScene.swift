
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    override func buildScene() {
        addChild(_object)
        _object.setPositionZ(-5)
    }
    
    override func onUpdate() {
        _object.rotateY(GameTime.DeltaTime)
        _object.rotateX(GameTime.DeltaTime)
    }
    
}
