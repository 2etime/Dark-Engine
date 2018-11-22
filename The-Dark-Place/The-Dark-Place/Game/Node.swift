
import MetalKit

class Node {
    private var _name: String = ""
    private var id: Int = -1
    public var isCollided: Bool = false
    private var _position: float3 = float3(0)
    private var _scale: float3 = float3(1)
    private var _rotation: float3 = float3(0)
    
    public var parentModelMatrix = matrix_identity_float4x4
    public var parentOffset = float3(0)

    private var _modelConstants = ModelConstants()
    private var _children: [Node] = []
    
    var offset: float3 = float3(0)
    
    var modelMatrix: matrix_float4x4{
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.translate(_position)
        modelMatrix.rotate(_rotation)
        modelMatrix.scale(_scale)
        return matrix_multiply(parentModelMatrix, modelMatrix)
    }
    
    init() {
        self._name = "Node"
    }
    
    init(name: String){
        self._name = name
    }
    
    func setID(_ id: Int){
        self.id = id
    }
    
    func addChild(_ child: Node) {
//        self.id = World.addObject(child)
        _children.append(child)
    }
    
    private func updateModelConstants(){
        self._modelConstants.modelMatrix = self.modelMatrix
        self._modelConstants.offset = self.offset + parentOffset
    }
    
    func update(){
        for child in _children {
            child.parentModelMatrix = self.modelMatrix
            child.parentOffset = self.offset
            child.update()
        }
        onUpdate()
        updateModelConstants()
    }
    
    func onUpdate(){
        //Override using this function
    }
    
    func zPassRender(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.pushDebugGroup("Z Passing \(_name)")
        for child in _children {
            child.zPassRender(renderCommandEncoder)
        }
        
        if let renderable = self as? Renderable {
            renderable.doZPass(renderCommandEncoder)
        }
        renderCommandEncoder.popDebugGroup()
    }
    
    func render(_ renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.pushDebugGroup("Rendering \(_name)")
        for child in _children {
            child.render(renderCommandEncoder)
        }
        
        if let renderable = self as? Renderable {
            renderCommandEncoder.setTriangleFillMode(.fill)
            renderCommandEncoder.setCullMode(.none)
            renderCommandEncoder.setVertexBytes(&_modelConstants, length: ModelConstants.stride, index: 2)
            renderable.doRender(renderCommandEncoder)
        }
        renderCommandEncoder.popDebugGroup()
    }
    
}

extension Node {
    //Naming
    func setName(_ name: String){ self._name = name }
    func getName()->String{ return _name }
    
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
    
    //Rotating
    func setRotation(_ rotation: float3) { self._rotation = rotation }
    func setRotationX(_ xRotation: Float) { self._rotation.x = xRotation }
    func setRotationY(_ yRotation: Float) { self._rotation.y = yRotation }
    func setRotationZ(_ zRotation: Float) { self._rotation.z = zRotation }
    func getRotation()->float3 { return self._rotation }
    func getRotationX()->Float { return self._rotation.x }
    func getRotationY()->Float { return self._rotation.y }
    func getRotationZ()->Float { return self._rotation.z }
    func rotateX(_ delta: Float){ self._rotation.x += delta }
    func rotateY(_ delta: Float){ self._rotation.y += delta }
    func rotateZ(_ delta: Float){ self._rotation.z += delta }
    
    //Scaling
    func setScale(_ scale: float3){ self._scale = scale }
    func setScale(_ scale: Float){setScale(float3(scale))}
    func setScaleX(_ scaleX: Float){ self._scale.x = scaleX }
    func setScaleY(_ scaleY: Float){ self._scale.y = scaleY }
    func setScaleZ(_ scaleZ: Float){ self._scale.z = scaleZ }
    func getScale()->float3 { return self._scale }
    func getScaleX()->Float { return self._scale.x }
    func getScaleY()->Float { return self._scale.y }
    func getScaleZ()->Float { return self._scale.z }
    func scaleX(_ delta: Float){ self._scale.x += delta }
    func scaleY(_ delta: Float){ self._scale.y += delta }
    func scaleZ(_ delta: Float){ self._scale.z += delta }
}
