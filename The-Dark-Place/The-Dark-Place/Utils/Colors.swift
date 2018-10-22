import MetalKit

class Colors {
    
    enum ClearColors {
        static let WHITE = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static let FOREST_GREEN = MTLClearColor(red: 0.2, green: 0.5, blue: 0.3, alpha: 1.0)
        static let DARK_GRAY = MTLClearColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
    }
    
    static var random: float4{
        return float4(Math.randomZeroToOne,
                      Math.randomZeroToOne,
                      Math.randomZeroToOne,
                      1.0)
    }
}
