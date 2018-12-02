
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    var terrain = SingleTextureTerrain(.Grass)
    var lightThing = Cube()
    var vertexBuffer: MTLBuffer!
    var vertexCount: Int = 0
    
    override func buildScene() {
        
        //Setup Camera
        currentCamera.setPositionZ(5)
        currentCamera.setPositionY(1)
        
        //Add Lights
        lightData.color = lightThing.getColor().xyz
        lightData.position = float3(0,500,500)
//        lightThing.setScale(0.2)
//        addChild(lightThing)
        
        let loader = FontLoader(fontFileName: "OperatorFont")
        let vertices = loader.getFontCharacter("ABCDEFGHIJKLMNOPQRSTUVWXYZ", fontSize: 3)
        
        vertexCount = vertices.count
        vertexBuffer = DarkEngine.Device.makeBuffer(bytes: vertices,
                                                    length: Vertex.stride(vertices.count),
                                                    options: [])
    }
    
    override func render(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Text])
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setFragmentTexture(Entities.Textures[.OperatorFont], index: 0)
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertexCount)
        super.render(renderCommandEncoder)
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
