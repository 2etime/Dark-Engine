
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    var terrain = SingleTextureTerrain(.Grass)
    var lightThing = Cube()

    var textObject: TextObject!
    
    override func buildScene() {
        
        //Setup Camera
        currentCamera.setPositionZ(5)
        currentCamera.setPositionY(1)
        
        //Add Lights
        lightData.color = lightThing.getColor().xyz
        lightData.position = float3(0,500,500)
//        lightThing.setScale(0.2)
//        addChild(lightThing)
        
        textObject = TextObject(initialText: "0:00",
                                fontType: .OperatorFont,
                                fontSize: 2,
                                margin: float4(0,0,0,0.02))
        
        addChild(textObject)
    }
    
    override func onUpdate() {
        textObject.updateText(String(format: "%.2f", GameTime.TotalGameTime))
        
        if(Keyboard.IsKeyPressed(.space)){
            textObject.updateFont(.Luminari)
        }
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
