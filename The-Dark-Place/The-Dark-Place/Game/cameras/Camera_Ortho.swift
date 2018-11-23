
import MetalKit


class Camera_Ortho: Camera {
    override var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.orthographic(right: 5,
                                            left: -5,
                                            top: 5,
                                            bottom: -5,
                                            near: -50,
                                            far: 50)
    }
    
    override func doUpdate() {
        
    }
    
}
