
import MetalKit

class StandingGrass: GameObject {
    
    init(name: String = "StandingGrass"){
        super.init(.Quad_Custom, textureType: .StandingGrass)
        self.setName(name)
        material.specularIntensity = 0.6
        material.shininess = 200
        material.ambientIntensity = 0.3
        material.diffuseIntensity = 0.3
        
        let crossGrass = GameObject(.Quad_Custom, textureType: .StandingGrass)
        crossGrass.setRotationY(toRadians(90))
        addChild(crossGrass)
        
        self.setRotationY(0.4)
    }
}
