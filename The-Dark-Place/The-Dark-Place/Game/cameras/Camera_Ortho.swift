
import MetalKit


class Camera_Ortho: Camera {
    
    let cellsWide: Float = 2
    override var projectionMatrix: matrix_float4x4 {
        get {
            let unitsWide: Float = 2
            let unitsTall = GameView.Height / (GameView.Width / unitsWide)
            return matrix_float4x4.orthographic(right: unitsWide / 2.0,
                                                left: -unitsWide / 2.0,
                                                top: unitsTall / 2.0,
                                                bottom: -unitsTall / 2.0,
                                                near: -10.0,
                                                far: 10.0)
        }
        set { }
    }
    
}
