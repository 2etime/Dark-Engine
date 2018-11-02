
import MetalKit

class InstancedGameObject: Node {
    
    private var _nodes: [Node] = []
    private var _modelConstantsBuffer: MTLBuffer!
    private var _instanceCount: Int = 1
    
    init(meshType: MeshTypes, instanceCount: Int){
        super.init()
        self._instanceCount = instanceCount
        generateInstances()
    }
    
    func generateInstances() {
        for _ in 0..<_instanceCount {
            _nodes.append(Node())
        }
    }
    
    func createBuffer() {
        _modelConstantsBuffer = DarkEngine.Device.makeBuffer(length: ModelConstants.stride(_instanceCount), options: [])
    }
    
}

extension InstancedGameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        
    }
}
