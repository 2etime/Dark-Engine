import MetalKit

enum DepthStencilStateTypes {
    case Less
    case LightMask
    case DirectionalLight
    case GBuffer
    case Shadow
}

class DepthStencilStateLibrary: Library<DepthStencilStateTypes, MTLDepthStencilState> {
    
    private var library: [DepthStencilStateTypes : DepthStencilState] = [:]
    
    override func fillLibrary() {
        library.updateValue(Less_DepthStencilState(), forKey: .Less)
        library.updateValue(LightMask_DepthStencilState(), forKey: .LightMask)
        library.updateValue(DirectionLight_DepthStencilState(), forKey: .DirectionalLight)
        library.updateValue(GBuffer_DepthStencilState(), forKey: .GBuffer)
        library.updateValue(Shadow_DepthStencilState(), forKey: .Shadow)
    }
    
    override subscript(_ type: DepthStencilStateTypes) -> MTLDepthStencilState {
        return (library[type]?.depthStencilState!)!
    }
    
}

protocol DepthStencilState {
    var name: String { get }
    var depthStencilState: MTLDepthStencilState! { get }
}

class Less_DepthStencilState: DepthStencilState {
    var name: String = "Less Depth Stencil State"
    var depthStencilState: MTLDepthStencilState!
    
    init() {
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilDescriptor.isDepthWriteEnabled = true
        self.depthStencilState = DarkEngine.Device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
}
class LightMask_DepthStencilState: DepthStencilState {
    var name: String = "Light Mask Depth Stencil State"
    var depthStencilState: MTLDepthStencilState!
    
    init() {
        let stencilStateDescriptor = MTLStencilDescriptor()
        stencilStateDescriptor.stencilCompareFunction = .always
        stencilStateDescriptor.stencilFailureOperation = .keep
        stencilStateDescriptor.depthFailureOperation = .incrementClamp
        stencilStateDescriptor.depthStencilPassOperation = .keep
        stencilStateDescriptor.readMask = 0x0
        stencilStateDescriptor.writeMask = 0xFF
        
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.label = "Point Light Mask"
        depthStencilDescriptor.isDepthWriteEnabled = false
        depthStencilDescriptor.depthCompareFunction = .lessEqual
        depthStencilDescriptor.frontFaceStencil = stencilStateDescriptor
        depthStencilDescriptor.backFaceStencil = stencilStateDescriptor
        self.depthStencilState = DarkEngine.Device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
}
class DirectionLight_DepthStencilState: DepthStencilState {
    var name: String = "Directional Light Depth Stencil State"
    var depthStencilState: MTLDepthStencilState!
    
    init() {
        var stencilStateDescriptor: MTLStencilDescriptor?
        if(Options.LightStencilCulling){
            stencilStateDescriptor = MTLStencilDescriptor()
            stencilStateDescriptor?.stencilCompareFunction = .equal
            stencilStateDescriptor?.stencilFailureOperation = .keep
            stencilStateDescriptor?.depthFailureOperation = .keep
            stencilStateDescriptor?.depthStencilPassOperation = .keep
            stencilStateDescriptor?.readMask = 0x0
            stencilStateDescriptor?.writeMask = 0xFF
        }else {
            stencilStateDescriptor = nil
        }
        
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.label = "Deferred Directional Lighting"
        depthStencilDescriptor.isDepthWriteEnabled = false
        depthStencilDescriptor.depthCompareFunction = .always
        depthStencilDescriptor.frontFaceStencil = stencilStateDescriptor
        depthStencilDescriptor.backFaceStencil = stencilStateDescriptor
        self.depthStencilState = DarkEngine.Device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
}
class GBuffer_DepthStencilState: DepthStencilState {
    var name: String = "GBuffer Depth Stencil State"
    var depthStencilState: MTLDepthStencilState!
    
    init() {
        var stencilStateDescriptor: MTLStencilDescriptor?
        if(Options.LightStencilCulling){
            stencilStateDescriptor = MTLStencilDescriptor()
            stencilStateDescriptor?.stencilCompareFunction = .always
            stencilStateDescriptor?.stencilFailureOperation = .keep
            stencilStateDescriptor?.depthFailureOperation = .keep
            stencilStateDescriptor?.depthStencilPassOperation = .replace
            stencilStateDescriptor?.readMask = 0x0
            stencilStateDescriptor?.writeMask = 0xFF
        }else {
            stencilStateDescriptor = nil
        }
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.label = "GBuffer Creation"
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.frontFaceStencil = stencilStateDescriptor
        depthStencilDescriptor.backFaceStencil = stencilStateDescriptor
        self.depthStencilState = DarkEngine.Device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
}
class Shadow_DepthStencilState: DepthStencilState {
    var name: String = "Shadow Depth Stencil State"
    var depthStencilState: MTLDepthStencilState!
    
    init() {
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.label = "Shadow Gen"
        if(Options.ReverseDepth){
            depthStencilDescriptor.depthCompareFunction = .greaterEqual
        }else{
            depthStencilDescriptor.depthCompareFunction = .lessEqual
        }
        depthStencilDescriptor.isDepthWriteEnabled = true
        self.depthStencilState = DarkEngine.Device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
}
