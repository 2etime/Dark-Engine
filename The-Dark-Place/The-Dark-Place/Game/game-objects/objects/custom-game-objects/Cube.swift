
import MetalKit

class Cube: GameObject {
    
    override var renderPipelineState: MTLRenderPipelineState {
        return Graphics.RenderPipelineStates[.MDLMesh]
    }
    
    init(name: String = "Cube"){
        super.init(.CubeBasic_Apple)
        self.setName(name)
    }
    
    override func onUpdate() {
        self.rotateY(GameTime.DeltaTime)
    }
    
}
