
import MetalKit

class PlaygroundScene: Scene {

    private var _object = Cube()
    
    override func setupCameras() {
        setCurrentCamera(.Debug)
    }
    
    let skybox = SkyboxGameObject(.Sky)
    var terrain = Terrain(cellCount: 100)
    var lightThing = Cube()
    var armadillo = Armadillo()
    let pirateShip = PirateShip()
    var globe = Globe()
    let cruiser = Cruiser()
    var instancedGrass = GrassPatch(patchWidth: 100, patchDepth: 100, grassCount: 100)
    var card = Card()
    override func buildScene() {
        skybox.setPositionY(20)
        addChild(skybox)
        

        terrain.setScale(100)
        terrain.setDiffuseIntensity(0.4)
        addChild(terrain)
        
        addChild(instancedGrass)

        currentCamera.setPositionZ(7)
        currentCamera.setPositionY(2)

        lightThing.setScale(0.2)
        lightThing.setPositionZ(-2)
        addChild(lightThing)
        
        lightData.color = lightThing.getColor().xyz
        
        armadillo.setPositionY(1)
        armadillo.setPositionX(3)
        armadillo.setColor(float4(1,0,0,1))
        addChild(armadillo)
        
        pirateShip.setScale(0.5)
        pirateShip.setPositionX(-3)
        addChild(pirateShip)

        addChild(globe)
        
        cruiser.setPositionY(4)
        cruiser.setPositionX(0)
        cruiser.setRotationZ(0.7)
        addChild(cruiser)
        
        
        card.setPositionZ(5)
        card.setPositionY(2)
        card.setColor(float4(1,1,1,0.2))
        addChild(card)
    }

    override func onUpdate() {
        skybox.rotateY(GameTime.DeltaTime / 20)
        lightData.position.y = abs((cos(GameTime.TotalGameTime * 0.3) * 10))
        lightThing.setPosition(lightData.position)
        armadillo.rotateY(GameTime.DeltaTime)
        pirateShip.rotateY(GameTime.DeltaTime)
        globe.rotateY(GameTime.DeltaTime)
        cruiser.rotateY(GameTime.DeltaTime)
    }
    
}
