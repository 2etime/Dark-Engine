
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    let skybox = SkyboxGameObject()
    override func buildScene() {
//        addChild(_object)
        
//        skybox.setScale(1000)
//        skybox.setPositionY(-100)
        addChild(skybox)
    }
    
    override func onUpdate() {
//        currentCamera.setPositionX(cos(GameTime.TotalGameTime))
//        currentCamera.doYaw(GameTime.DeltaTime / 4)
        skybox.rotateY(GameTime.DeltaTime / 50)
//        _object.rotateY(GameTime.DeltaTime)
//        _object.rotateX(GameTime.DeltaTime)
    }
    
}
