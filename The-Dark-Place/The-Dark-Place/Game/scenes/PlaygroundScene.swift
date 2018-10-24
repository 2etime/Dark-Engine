
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    override func buildScene() {
        addChild(_object)
        _object.setScale(5)
        _object.setPositionY(-8)
        _object.setPositionZ(-4)
        currentCamera.doPitch(0.3)
        currentCamera.setPositionZ(2)
        
        let lightThing = Cube()
        lightThing.setScale(0.02)
        lightThing.setPosition(float3(0,0.2,-3))
        addChild(lightThing)
    }
    
    override func onUpdate() {
//        _object.rotateY(GameTime.DeltaTime)
//        _object.rotateX(GameTime.DeltaTime)
    }
    
}
