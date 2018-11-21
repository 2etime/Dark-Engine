import MetalKit

enum RenderPassDescriptorTypes {
    case Shadow
}

class RenderPassDescriptorLibrary: Library<RenderPassDescriptorTypes, MTLRenderPassDescriptor> {
    
    private var library: [RenderPassDescriptorTypes : RenderPassDescriptor] = [:]
    
    override func fillLibrary() {
        library.updateValue(Shadow_RenderPassDescriptor(), forKey: .Shadow)
    }
    
    override subscript(_ type: RenderPassDescriptorTypes) -> MTLRenderPassDescriptor {
        return (library[type]?.renderPassDescriptor!)!
    }
    
}

protocol RenderPassDescriptor {
    var name: String { get }
    var renderPassDescriptor: MTLRenderPassDescriptor! { get }
}

class Shadow_RenderPassDescriptor: RenderPassDescriptor {
    var name: String = "Shadow Render Pass Descriptor"
    var renderPassDescriptor: MTLRenderPassDescriptor!
    
    init(){
        let shadowTextureDesc = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .depth32Float,
                                                                         width: 2048,
                                                                         height: 2048,
                                                                         mipmapped: false)
        shadowTextureDesc.resourceOptions = MTLResourceOptions.storageModePrivate
        shadowTextureDesc.usage = [MTLTextureUsage.shaderRead, MTLTextureUsage.renderTarget]
        
        renderPassDescriptor = MTLRenderPassDescriptor()
        
        let shadowMap = DarkEngine.Device.makeTexture(descriptor: shadowTextureDesc)
        shadowMap?.label = "Shadow Map"
        Entities.Textures.UpdateTexture(textureType: .Depth, texture: shadowMap!)
        
        renderPassDescriptor.depthAttachment.texture = Entities.Textures[.Depth]
        renderPassDescriptor.depthAttachment.loadAction = .clear
        renderPassDescriptor.depthAttachment.storeAction = .store
        renderPassDescriptor.depthAttachment.clearDepth = 1.0
    }
}
