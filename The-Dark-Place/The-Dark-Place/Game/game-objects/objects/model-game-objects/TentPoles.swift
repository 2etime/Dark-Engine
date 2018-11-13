import MetalKit

class TentPoles: ModelGameObject {
    init(){
        super.init(meshType: .TentPoles1)
        self.offset = float3(-width / 2.0,0,depth / 2)
    }
}
