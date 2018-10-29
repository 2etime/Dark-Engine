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

public func toRadians(_ degrees: Float)->Float{
    return (degrees / 180) * Float.pi
}

public func toDegrees(_ radians: Float) -> Float{
    return radians * (180 / Float.pi)
}

class Math {
    
    static var randomZeroToOne: Float{
        return Float(arc4random()) / Float(UINT32_MAX)
    }
    
    static func randomBounded(lowerBound: Int, upperBound: Int) -> Int {
        return lowerBound + Int(arc4random_uniform(UInt32(upperBound - lowerBound)))
    }
    
}

