import MetalKit

enum SamplerStateTypes {
    case Linear
    case Nearest
    case Linear_Repeat
}

class SamplerStateLibrary: Library<SamplerStateTypes, MTLSamplerState> {
    
    private var library: [SamplerStateTypes : SamplerState] = [:]
    
    override func fillLibrary() {
        library.updateValue(Linear_SamplerState(), forKey: .Linear)
        library.updateValue(Nearest_SamplerState(), forKey: .Nearest)
        library.updateValue(Linear_Nearest_SamplerState(), forKey: .Linear_Repeat)
    }
    
    override subscript(_ type: SamplerStateTypes) -> MTLSamplerState {
        return (library[type]?.samplerState!)!
    }
    
}

protocol SamplerState {
    var name: String { get }
    var samplerState: MTLSamplerState! { get }
}

class Linear_SamplerState: SamplerState {
    var name: String = "Linear Sampler State"
    var samplerState: MTLSamplerState!
    
    init() {
        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.minFilter = .linear
        samplerDescriptor.magFilter = .linear
        samplerState = DarkEngine.Device.makeSamplerState(descriptor: samplerDescriptor)
    }
}

class Nearest_SamplerState: SamplerState {
    var name: String = "Nearest Sampler State"
    var samplerState: MTLSamplerState!
    
    init() {
        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.minFilter = .nearest
        samplerDescriptor.magFilter = .nearest
        samplerState = DarkEngine.Device.makeSamplerState(descriptor: samplerDescriptor)
    }
}

class Linear_Nearest_SamplerState: SamplerState {
    var name: String = "Linear Nearest Sampler State"
    var samplerState: MTLSamplerState!
    
    init() {
        let samplerDescriptor = MTLSamplerDescriptor()
        samplerDescriptor.minFilter = .nearest
        samplerDescriptor.magFilter = .nearest
        samplerDescriptor.sAddressMode = .repeat
        samplerDescriptor.rAddressMode = .repeat
        samplerDescriptor.tAddressMode = .repeat
        samplerState = DarkEngine.Device.makeSamplerState(descriptor: samplerDescriptor)
    }
}
