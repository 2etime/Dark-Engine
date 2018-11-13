import MetalKit

class Campfire: ModelGameObject {
    init(){
        super.init(meshType: .Campfire1)
        self.offset = float3(-width / 2.0,0,depth / 2)
    }
}
