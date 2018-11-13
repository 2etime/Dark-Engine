
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    let skybox = SkyboxGameObject(.Sky)
    var terrain = SingleTextureTerrain(.Grass)
    var lightThing = Cube()
    override func buildScene() {
        skybox.setPositionY(20)
        addChild(skybox)
        
        terrain.setScale(100)
        terrain.setDiffuseIntensity(0.4)
        addChild(terrain)
   
        currentCamera.setPositionZ(7)
        currentCamera.setPositionY(2)

        lightThing.setScale(0.2)
        lightThing.setPositionY(3)
        lightThing.setPositionZ(-2)
        addChild(lightThing)
        
        lightData.color = lightThing.getColor().xyz
        lightData.attenuation = float3(0.71000016, -0.069999784, 0.08999999)
        
    }

    override func onUpdate() {
        skybox.rotateY(GameTime.DeltaTime / 20)
//        lightData.position.y = abs((cos(GameTime.TotalGameTime * 0.3) * 10))
//        lightThing.setPosition(lightData.position)
        
        if(Keyboard.IsKeyPressed(.upArrow)){
            currentCamera.moveZ(-GameTime.DeltaTime * 2)
        }
        
        if(Keyboard.IsKeyPressed(.downArrow)){
            currentCamera.moveZ(GameTime.DeltaTime * 2)
        }
        
        if(Keyboard.IsKeyPressed(.leftArrow)){
            currentCamera.moveX(-GameTime.DeltaTime * 2)
        }
        
        if(Keyboard.IsKeyPressed(.rightArrow)){
            currentCamera.moveX(GameTime.DeltaTime * 2)
        }
    }
    
}
