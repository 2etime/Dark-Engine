
import MetalKit

class Cube: GameObject {
    
    override var renderPipelineState: MTLRenderPipelineState {
        return Graphics.RenderPipelineStates[.MDLMesh]
    }
    
    init(){
        super.init(.CubeBasic_Apple)
    }
    
}
