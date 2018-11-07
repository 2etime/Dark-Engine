import MetalKit

class Globe: ModelGameObject {
    init(){
        super.init(meshType: .Globe)
        self.setName("Globe")
        self.setScale(0.05)
    }
}
