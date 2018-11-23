
import MetalKit

class CastleDefenseScene: Scene {

    override func setupCameras() {
        setCurrentCamera(.Ortho)
    }
    
    override func buildScene() {
        //Setup Camera
        currentCamera.setPositionZ(5)
        
        //Add Lights
        lightData.color = float3(1)
        lightData.position = float3(0,5,3)
        
        var redCard = Card()
        redCard.setColor(float4(1,0,0,1))
        redCard.setPositionZ(1)
        redCard.setPositionX(-0.5)
        addChild(redCard)
    }
    
    override func onUpdate() {
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

