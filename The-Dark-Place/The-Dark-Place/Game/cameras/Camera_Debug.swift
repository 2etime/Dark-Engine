
import MetalKit


class Camera_Debug: Camera {
    
    var zoom: Float  = 90.0
    var aspectRatio: Float = 1.0
    var near: Float = 0.1
    var far: Float = 1000.0
    
    override var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: zoom, aspectRatio: aspectRatio, near: near, far: far)
    }

    override func doUpdate() {
        self.doRoll(GameTime.DeltaTime)
    }
    
}
