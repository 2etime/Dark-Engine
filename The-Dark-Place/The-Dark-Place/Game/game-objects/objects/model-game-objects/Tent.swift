import MetalKit

class Tent: ModelGameObject {
    init(){
        super.init(meshType: .Tent1)
        self.offset = float3(-width / 2.0,0,depth / 2)
    }
}
