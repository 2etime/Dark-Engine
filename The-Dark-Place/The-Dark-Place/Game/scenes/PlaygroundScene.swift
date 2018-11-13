
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    let skybox = SkyboxGameObject(.Sky)
    var terrain = MultiTextureTerrain()
    var lightThing = Cube()
    var tentPoles = TentPoles()
    var tent = Tent()
    var campfire = Campfire()
    override func buildScene() {
        skybox.setPositionY(20)
        addChild(skybox)
        
        terrain.setScale(100)
        terrain.setDiffuseIntensity(0.4)
        addChild(terrain)
   
        currentCamera.setPositionZ(15)
        currentCamera.setPositionY(6)
        currentCamera.setPitch(0.3)

        lightThing.setScale(0.2)
        addChild(lightThing)
        
        lightData.color = lightThing.getColor().xyz
        lightData.position = float3(0,5,3)
        lightData.attenuation = float3(0.0, -0.069999784, 0.08999999)
        
        tentPoles.rotateY(toRadians(195))
        tentPoles.moveX(-3)
        addChild(tentPoles)
        
        tent.rotateY(toRadians(155))
        tent.moveX(3)
        addChild(tent)
        
        campfire.setPositionZ(3)
        addChild(campfire)
        
    }

    override func onUpdate() {
        skybox.rotateY(GameTime.DeltaTime / 20)
//        lightData.position.y = abs((cos(GameTime.TotalGameTime * 0.3) * 10))
        lightThing.setPosition(lightData.position)
        
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
