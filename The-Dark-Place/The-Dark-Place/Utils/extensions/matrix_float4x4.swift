
import MetalKit

extension matrix_float4x4 {

    mutating func translate(_ direction: float3) {
        var result = matrix_identity_float4x4
        
        let x: Float = direction.x
        let y: Float = direction.y
        let z: Float = direction.z
        
        result.columns = (
            float4(1, 0, 0, 0),
            float4(0, 1, 0, 0),
            float4(0, 0, 1, 0),
            float4(x, y, z, 1)
        )
        
        self = matrix_multiply(self, result)
    }
    
}
