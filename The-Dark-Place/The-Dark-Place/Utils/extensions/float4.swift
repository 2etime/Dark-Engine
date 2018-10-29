
import MetalKit

extension float4 {
    var xyz: float3 {
        return float3(self.x, self.y, self.z)
    }
}
