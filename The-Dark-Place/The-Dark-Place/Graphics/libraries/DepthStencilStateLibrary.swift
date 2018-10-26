import MetalKit

enum DepthStencilStateTypes {
    case Less
}

class DepthStencilStateLibrary: Library<DepthStencilStateTypes, MTLDepthStencilState> {
    
    private var library: [DepthStencilStateTypes : DepthStencilState] = [:]
    
    override func fillLibrary() {
        library.updateValue(Less_DepthStencilState(), forKey: .Less)
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
