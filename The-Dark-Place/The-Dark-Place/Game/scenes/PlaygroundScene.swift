
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    let skybox = SkyboxGameObject(.Sky)
    var terrain = Terrain(cellCount: 100)
    override func buildScene() {
        skybox.setPositionY(20)
        addChild(skybox)
        
        terrain.setScale(100)
        terrain.setAmbientIntensity(0.4)
        addChild(terrain)
        
        currentCamera.setPositionZ(40)
        currentCamera.setPositionY(5)
        
        let gap: Float = 2
        for x in -20..<20{
            for z in -20..<20{
                var object = Cube()
//                object.setRotationY(Math.randomZeroToOne)
                object.setPosition(float3((Float(x) * gap),0.5,(Float(z) * gap)))
                object.setColor(Colors.random)
                object.setAmbientIntensity(0.4)
                addChild(object)
            }
        }
        
    }

    override func onUpdate() {
        skybox.rotateY(GameTime.DeltaTime / 20)
    }
    
}
