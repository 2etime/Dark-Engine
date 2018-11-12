import MetalKit

enum DepthStencilStateTypes {
    case Less
    case DontWrite
    case Shadow
}

class DepthStencilStateLibrary: Library<DepthStencilStateTypes, MTLDepthStencilState> {
    
    private var library: [DepthStencilStateTypes : DepthStencilState] = [:]
    
    override func fillLibrary() {
        library.updateValue(Less_DepthStencilState(), forKey: .Less)
        library.updateValue(DontWrite_DepthStencilState(), forKey: .DontWrite)
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

class DontWrite_DepthStencilState: DepthStencilState {
    var name: String = "Don't Write Depth Stencil State"
    var depthStencilState: MTLDepthStencilState!
    
    init() {
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.label = "Less - Writes"
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilDescriptor.isDepthWriteEnabled = false
        self.depthStencilState = DarkEngine.Device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
}

class Shadow_DepthStencilState: DepthStencilState {
    var name: String = "Shadow Depth Stencil State"
    var depthStencilState: MTLDepthStencilState!
    
    init() {
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.label = "Less - Writes"
        depthStencilDescriptor.depthCompareFunction = .lessEqual
        depthStencilDescriptor.isDepthWriteEnabled = true
        self.depthStencilState = DarkEngine.Device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
}
