import MetalKit

class Statue: ModelGameObject {
    init(){
        super.init(meshType: .Statue)
        self.setName("Statue")
        self.setScale(0.05)
    }
}
