
import MetalKit

class Cruiser: ModelGameObject {
    init(){
        super.init(meshType: .Cruiser)
        self.setName("Cruiser")
        self.setModelTexture(textureType: .Cruiser)
    }
}
