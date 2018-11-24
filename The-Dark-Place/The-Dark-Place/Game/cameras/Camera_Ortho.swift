
import MetalKit


class Camera_Ortho: Camera {
    
    let cellsWide: Float = 2
    override var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.orthographic(right: 2,
                                            left: -2,
                                            top: 2,
                                            bottom: -2,
                                            near: -50,
                                            far: 50)
    }
    
}
