
import MetalKit

class Node {
    private var _position: float3 = float3(0)

    private var _modelConstants = ModelConstants()
    private var _children: [Node] = []
    
    var modelMatrix: matrix_float4x4{
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.translate(_position)
        return modelMatrix
    }
    
    func addChild(_ child: Node) {
        _children.append(child)
    }
    
    private func updateModelConstants(){
        self._modelConstants.modelMatrix = self.modelMatrix
    }
    
    func update(_ deltaTime: Float){
        for child in _children {
            child.update(deltaTime)
        }
        onUpdate(deltaTime)
        updateModelConstants()
    }
    
    func onUpdate(_ deltaTime: Float){
        //Override using this function
    }
    
    func render(_ renderCommandEncoder: MTLRenderCommandEncoder){
        for child in _children {
            child.render(renderCommandEncoder)
        }
        
        if let renderable = self as? Renderable {
            renderCommandEncoder.setVertexBytes(&_modelConstants, length: ModelConstants.stride, index: 1)
            renderable.doRender(renderCommandEncoder)
        }
    }
    
}

extension Node {
    //Positioning and Movement
    func setPosition(_ position: float3){ self._position = position }
    func setPositionX(_ xPosition: Float) { self._position.x = xPosition }
    func setPositionY(_ yPosition: Float) { self._position.y = yPosition }
    func setPositionZ(_ zPosition: Float) { self._position.z = zPosition }
    func getPosition()->float3 { return self._position }
    func getPositionX()->Float { return self._position.x }
    func getPositionY()->Float { return self._position.y }
    func getPositionZ()->Float { return self._position.z }
    func moveX(_ delta: Float){ self._position.x += delta }
    func moveY(_ delta: Float){ self._position.y += delta }
    func moveZ(_ delta: Float){ self._position.z += delta }
}
