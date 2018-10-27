import MetalKit

enum RenderPipelineDescriptorTypes {
    case Basic
    case Skybox
}

class RenderPipelineDescriptorLibrary: Library<RenderPipelineDescriptorTypes, MTLRenderPipelineDescriptor> {
    private var library: [RenderPipelineDescriptorTypes : RenderPipelineDescriptor] = [:]
    
    override func fillLibrary() {
        library.updateValue(Basic_RenderPipelineDescriptor(), forKey: .Basic)
        library.updateValue(Skybox_RenderPipelineDescriptor(), forKey: .Skybox)
    }
    
    override subscript(_ type: RenderPipelineDescriptorTypes) -> MTLRenderPipelineDescriptor {
        return (library[type]?.renderPipelineDescriptor!)!
    }
}

protocol RenderPipelineDescriptor {
    var name: String { get }
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor! { get }
}

class Basic_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Basic Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Basic]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
    }
    
}

class Skybox_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Skybox Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Skybox]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Skybox]
    }
    
}


