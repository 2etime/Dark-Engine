
import MetalKit

class BasicScene: Scene {
    
    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    let skybox = SkyboxGameObject(.Sky)
    var terrain = SingleTextureTerrain(.Grass)
    var lightThing = Cube()
    var card = Card()
    override func buildScene() {
        
        //Setup Camera
        currentCamera.setPositionZ(5)
        currentCamera.setPositionY(1)
        
        //Add Lights
        lightData.color = lightThing.getColor().xyz
        lightData.position = float3(0,5,3)
        //        lightData.attenuation = float3(0.0, -0.069999784, 0.08999999)
        
        lightThing.setScale(0.2)
        addChild(lightThing)
        
        //Add The Skybox
        skybox.setPositionY(20)
        addChild(skybox)
        
        //Add The Terrain
        terrain.setScale(100)
        terrain.setDiffuseIntensity(0.4)
        addChild(terrain)
        
        card.setTexture(textureType: .Bird)
        addChild(card)
    }
    
    override func onUpdate() {
        skybox.rotateY(GameTime.DeltaTime / 20)
        //        lightData.position.y = abs((cos(GameTime.TotalGameTime * 0.3) * 10))
        lightThing.setPosition(lightData.position)
        //        card.rotateY(GameTime.DeltaTime)
        
        
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
        
        if(Keyboard.IsKeyPressed(.q)){
            currentCamera.moveY(GameTime.DeltaTime * 2)
        }
        
        if(Keyboard.IsKeyPressed(.a)){
            currentCamera.moveY(-GameTime.DeltaTime * 2)
        }
        
        if(Mouse.IsMouseButtonPressed(button: .left)){
            currentCamera.doPitch(Mouse.GetDY() * 0.05)
            currentCamera.doYaw(Mouse.GetDX() * 0.05)
        }
    }
    
}
