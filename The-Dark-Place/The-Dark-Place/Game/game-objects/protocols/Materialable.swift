
import MetalKit

protocol Materialable {
    var material: Material! { get set }
}

extension Materialable {
    mutating func setColor(_ colorValue: float4){ self.material.color = colorValue }
    mutating func getColor()->float4{ return self.material.color }
    
    mutating func setAmbientIntensity(_ ambientValue: Float){ self.material.ambientIntensity = ambientValue }
    mutating func getAmbientIntensity()->Float { return self.material.ambientIntensity }
    mutating func increaseAmbientIntensity(_ value: Float) { self.material.ambientIntensity += value }
    
    mutating func setDiffuseIntensity(_ diffuseValue: Float){ self.material.diffuseIntensity = diffuseValue }
    mutating func getDiffuseIntensity()->Float { return self.material.diffuseIntensity }
    mutating func increaseDiffuseIntensity(_ value: Float) { self.material.diffuseIntensity += value }
}
