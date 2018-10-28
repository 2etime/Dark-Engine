import MetalKit

enum RenderPipelineDescriptorTypes {
    case Basic
    case Skybox
    case MDLMesh
    case TerrainTextured
}

class RenderPipelineDescriptorLibrary: Library<RenderPipelineDescriptorTypes, MTLRenderPipelineDescriptor> {
    private var library: [RenderPipelineDescriptorTypes : RenderPipelineDescriptor] = [:]
    
    override func fillLibrary() {
        library.updateValue(Basic_RenderPipelineDescriptor(), forKey: .Basic)
        library.updateValue(Skybox_RenderPipelineDescriptor(), forKey: .Skybox)
        library.updateValue(MDLMesh_RenderPipelineDescriptor(), forKey: .MDLMesh)
        library.updateValue(TerrainTextured_RenderPipelineDescriptor(), forKey: .TerrainTextured)
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
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.MDLMesh]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Skybox]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Skybox]
    }
}

class MDLMesh_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Basic Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.MDLMesh]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Basic]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
    }
}

class TerrainTextured_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Terrain Textured Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Terrain]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.TerrainTextured]
    }
}


