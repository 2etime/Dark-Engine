
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    let skybox = SkyboxGameObject(.Sky)
    let object = Cube()
    override func buildScene() {
        skybox.setScale(1000)
        skybox.setPositionY(100)
        addChild(skybox)
        
        addChild(object)
        
        currentCamera.setPositionZ(10)
    }
    
    override func onUpdate() {
        object.rotateY(GameTime.DeltaTime)
        object.rotateX(GameTime.DeltaTime)
        skybox.rotateY(GameTime.DeltaTime / 20)
    }
    
}
