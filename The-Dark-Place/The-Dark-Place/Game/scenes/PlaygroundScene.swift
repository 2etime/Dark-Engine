
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
        
        let terrain = Terrain(gridX: 0, gridZ: 0)
        addChild(terrain)
        
        
        
        currentCamera.setPositionZ(2)
        currentCamera.setPositionY(1)
        currentCamera.setPitch(0.2)
    }
    
    override func onUpdate() {
        object.rotateY(GameTime.DeltaTime)
        object.rotateX(GameTime.DeltaTime)
        skybox.rotateY(GameTime.DeltaTime / 20)
    }
    
}
