import simd

public var X_AXIS: float3{
    return float3(1,0,0)
}

public var Y_AXIS: float3{
    return float3(0,1,0)
}

public var Z_AXIS: float3{
    return float3(0,0,1)
}

class Math {
    
    static var randomZeroToOne: Float{
        return Float(arc4random()) / Float(UINT32_MAX)
    }
    
}

