
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
        
        let grass = StandingGrass()
        grass.setPositionY(4)
        grass.setPositionZ(-1)
        addChild(grass)
        
        terrain.setScale(100)
        terrain.setDiffuseIntensity(0.4)
        addChild(terrain)
        
        currentCamera.setPositionZ(5)
        currentCamera.setPositionY(4)
//        currentCamera.setPitch(0.05)
        
        lightThing.setScale(0.2)
//        lightThing.setColor(float4(0.4,0.7,0.6,1.0))
        addChild(lightThing)
        
        lightData.color = lightThing.getColor().xyz
        let gap: Float = 2
        for x in -20..<20{
            for z in -20..<20{
                var object = Cube()
//                object.setRotationY(Math.randomZeroToOne)
                object.setPosition(float3((Float(x) * gap),0.5,(Float(z) * gap)))
                object.setColor(float4(0.2))
                object.setSpecularIntensity(0.7)
                object.setShininess(200)
                object.setAmbientIntensity(0.2)
                addChild(object)
            }
        }
        
    }

    override func onUpdate() {
        skybox.rotateY(GameTime.DeltaTime / 20)
        lightData.position.y = abs((cos(GameTime.TotalGameTime * 0.3) * 10))
        lightThing.setPosition(lightData.position)
    }
    
}
