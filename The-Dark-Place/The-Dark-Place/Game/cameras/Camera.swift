import MetalKit

class Camera {
    private var _position: float3 = float3(0)
    private var _pitch: Float = 0
    private var _yaw: Float = 0
    private var _roll: Float = 0
    
    var projectionMatrix: matrix_float4x4 {
        return matrix_identity_float4x4
    }
    
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        
        viewMatrix.rotate(angle: self._pitch, axis: X_AXIS)
        viewMatrix.rotate(angle: self._yaw, axis: Y_AXIS)
        viewMatrix.rotate(angle: self._roll, axis: Z_AXIS)
        viewMatrix.translate(-self.getPosition())
        
        return viewMatrix
    }
    
    func doUpdate() {
        
    }
}

extension Camera {
    //Pitch
    public func setPitch(_ value: Float){ self._pitch = value }
    public func getPitch()->Float{ return _pitch }
    public func doPitch(_ delta: Float){ self._pitch += delta }
    
    //Yaw
    public func setYaw(_ value: Float){ self._yaw = value }
    public func getYaw()->Float{ return _yaw }
    public func doYaw(_ delta: Float){ self._yaw += delta }
    
    //Roll
    public func setRoll(_ value: Float){ self._roll = value }
    public func getRoll()->Float{ return self._roll }
    public func doRoll(_ delta: Float){ self._roll += delta }
    
    //Positioning
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
