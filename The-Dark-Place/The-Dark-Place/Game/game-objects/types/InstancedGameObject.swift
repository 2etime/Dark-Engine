
import MetalKit

class InstancedGameObject: Node {
    private var _mesh: Mesh!
    internal var _nodes: [Node] = []
    private var _modelConstantBuffer: MTLBuffer!
    private var _instanceCount: Int = 1
    var material: Material! = Material()
    private var _texture: MTLTexture!
    
    init(meshType: MeshTypes, textureType: TextureTypes, instanceCount: Int){
        super.init()
        self._instanceCount = instanceCount
        _mesh = Entities.Meshes[meshType]
        _mesh.setInstanceCount(instanceCount)
        _texture = Entities.Textures[textureType]
        generateInstances()
        createBuffer()
    }
    
    func generateInstances() {
        for _ in 0..<_instanceCount {
            _nodes.append(Node())
        }
    }
    
    func createBuffer() {
        _modelConstantBuffer = DarkEngine.Device.makeBuffer(length: ModelConstants.stride(_instanceCount), options: [])
    }
    
    func setTexture(textureType: TextureTypes){
        self.material.useTexture = true
    }

    
    private func updateModelConstantsBuffer() {
        var pointer = _modelConstantBuffer.contents().bindMemory(to: ModelConstants.self, capacity: _nodes.count)
        for node in _nodes {
            pointer.pointee.modelMatrix = matrix_multiply(self.modelMatrix, node.modelMatrix)
            pointer = pointer.advanced(by: 1)
        }
    }
    
    override func update() {
        updateModelConstantsBuffer()
        super.update()
    }
    
}

extension InstancedGameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Instanced])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])

        renderCommandEncoder.setVertexBuffer(_modelConstantBuffer, offset: 0, index: 2)

        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        
        renderCommandEncoder.setFragmentTexture(_texture, index: 0)
        
        _mesh.drawPrimitives(renderCommandEncoder)
    }
}

extension InstancedGameObject: Materialable {
    
}
