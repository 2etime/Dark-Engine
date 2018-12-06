
import MetalKit


class Camera_Ortho: Camera {
    
    let cellsWide: Float = 2
    override var projectionMatrix: matrix_float4x4 {
        let unitsWide: Float = 10
        let unitsTall = GameView.Height / (GameView.Width / unitsWide)
        return matrix_float4x4.orthographic(right: unitsWide / 2,
                                            left: -unitsWide / 2,
                                            top: unitsTall / 2,
                                            bottom: -unitsTall / 2,
                                            near: -10,
                                            far: 100)
//        return matrix_float4x4.orthographic(right: 2,
//                                            left: -2,
//                                            top: 2,
//                                            bottom: -2,
//                                            near: -50,
//                                            far: 50)
    }
    
}
