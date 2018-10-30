
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
        
        currentCamera.setPositionZ(20)
        currentCamera.setPositionY(6)
//        currentCamera.setPitch(0.05)
        
        lightThing.setScale(0.2)
//        lightThing.setColor(float4(0.4,0.7,0.6,1.0))
        addChild(lightThing)
        
        lightData.color = lightThing.getColor().xyz
        
        let ship = PirateShip()
        addChild(ship)
        
        for _ in -10..<10{
            for _ in -10..<10{
                var object = StandingGrass()
                let posX = Float(Math.randomBounded(lowerBound: -40, upperBound: 40))
                let posZ = Float(Math.randomBounded(lowerBound: -40, upperBound: 40))
//                object.setRotationY(Math.randomZeroToOne)
                object.setPosition(float3(posX, 0.4, posZ))
                object.setScale(0.6)
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
