import MetalKit

enum RenderPassDescriptorTypes {
    case Basic
    case Shadow
}

class RenderPassDescriptorLibrary: Library<RenderPassDescriptorTypes, RenderPassDescriptor> {
    
    private var library: [RenderPassDescriptorTypes : RenderPassDescriptor] = [:]
    
    override func fillLibrary() {
        library.updateValue(Basic_RenderPassDescriptor(), forKey: .Basic)
        library.updateValue(Shadow_RenderPassDescriptor(), forKey: .Shadow)
    }
    
    override subscript(_ type: RenderPassDescriptorTypes) -> RenderPassDescriptor {
        return library[type]!
    }
    
}

protocol RenderPassDescriptor {
    var name: String { get }
    var renderPassDescriptor: MTLRenderPassDescriptor! { get }
    var texture: MTLTexture! { get }
}

class Basic_RenderPassDescriptor: RenderPassDescriptor {
    var name: String = "Basic Render Pass Descriptor"
    var renderPassDescriptor: MTLRenderPassDescriptor!
    var texture: MTLTexture!
    init() {
        
    }
}

class Shadow_RenderPassDescriptor: RenderPassDescriptor {
    var name: String = "Shadow Render Pass Descriptor"
    var renderPassDescriptor: MTLRenderPassDescriptor!
    var texture: MTLTexture!
    init() {
        generateTexture()
        renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.depthAttachment.texture = texture
        renderPassDescriptor.depthAttachment.loadAction = .clear
        renderPassDescriptor.depthAttachment.storeAction = .store
        renderPassDescriptor.depthAttachment.clearDepth = 1.0
    }
    
    private func generateTexture(){
        let shadowTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .depth32Float,
                                                     width: 2048,
                                                     height: 2048,
                                                     mipmapped: false)
        shadowTextureDescriptor.resourceOptions = .storageModePrivate
        shadowTextureDescriptor.usage = [.renderTarget, .shaderRead]
        texture = DarkEngine.Device.makeTexture(descriptor: shadowTextureDescriptor)
        texture.label = "Shadow Map"
        
    }
}
