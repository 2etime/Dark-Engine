
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
        
        textObject = TextObject("hello world", fontType: .OperatorFont, fontSize: 3)
        addChild(textObject)
    }
    
    var gameTime: Float = 0
    var time: Int = 12
    override func onUpdate() {
        gameTime += GameTime.DeltaTime
        if(gameTime.remainder(dividingBy: 10) >= 0){
            time += 1
            gameTime = 0
            textObject.updateText(String(time))
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
