
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    let skybox = SkyboxGameObject(.Sky)
    var terrain = Terrain(cellCount: 100)
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
        lightThing.setPositionZ(-2)
        lightThing.setColor(Colors.random)
        addChild(lightThing)
        
        lightData.position.y = 1
        
        lightData.color = lightThing.getColor().xyz
        
        lightData.attenuation = float3(0.71000016, -0.069999784, 0.08999999)
        
    }

    override func onUpdate() {
        skybox.rotateY(GameTime.DeltaTime / 20)
//        lightData.position.y = abs((cos(GameTime.TotalGameTime * 0.3) * 10))
        lightThing.setPosition(lightData.position)
        
        if(Keyboard.IsKeyPressed(.one)){
            lightData.attenuation.x += 0.01
        }
        
        if(Keyboard.IsKeyPressed(.two)){
            lightData.attenuation.x -= 0.01
        }
        
        if(Keyboard.IsKeyPressed(.three)){
            lightData.attenuation.y += 0.01
        }
        
        if(Keyboard.IsKeyPressed(.four)){
            lightData.attenuation.y -= 0.01
        }
        
        if(Keyboard.IsKeyPressed(.five)){
            lightData.attenuation.z += 0.01
        }
        
        if(Keyboard.IsKeyPressed(.six)){
            lightData.attenuation.z -= 0.01
        }
        
        if(Keyboard.IsKeyPressed(.upArrow)){
            lightData.position.y += GameTime.DeltaTime
        }
        
        if(Keyboard.IsKeyPressed(.downArrow)){
            lightData.position.y -= GameTime.DeltaTime
        }
        
        print(lightData.attenuation)
    }
    
}
