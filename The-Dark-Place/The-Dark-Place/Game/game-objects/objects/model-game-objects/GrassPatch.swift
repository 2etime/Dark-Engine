

import MetalKit

class GrassPatch: InstancedGameObject {

    
    init(patchWidth: Int, patchDepth: Int, grassCount: Int){
        super.init(meshType: .Quad_Custom, instanceCount: grassCount)
        setName("Instanced Grass")
        
        setTexture(textureType: .StandingGrass)
        
        let halfWide: Float = Float(patchWidth / 2)
        let halfBack: Float = Float(patchDepth / 2)
        
        for count in 0..<grassCount{
            let object = _nodes[count]
    
            let posX = Float(Math.randomBounded(lowerBound: Int(-halfWide), upperBound: Int(halfWide)))
            let posZ = Float(Math.randomBounded(lowerBound: Int(-halfBack), upperBound: Int(halfBack)))
            object.setPosition(float3(posX, 0.4, posZ))
            object.setScale(0.6)
        }
    }
}
