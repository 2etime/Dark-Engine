import MetalKit

class Barrel: ModelGameObject {
    init(){
        super.init(meshType: .Barrel)
        self.offset = float3(0,6.02,0)
        self.setModelTexture(textureType: .Barrel)
    }
    
    override func onUpdate() {
        self.rotateY(GameTime.DeltaTime)
    }
    

}
