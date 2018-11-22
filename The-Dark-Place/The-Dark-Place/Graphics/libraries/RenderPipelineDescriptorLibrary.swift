import MetalKit

enum RenderPipelineDescriptorTypes {
    case Basic
    case Skybox
    case MDLMesh
    case TerrainTextured
    case Model
    case Instanced
    case TerrainMultiTextured
    case Bounding
}

class RenderPipelineDescriptorLibrary: Library<RenderPipelineDescriptorTypes, MTLRenderPipelineDescriptor> {
    private var library: [RenderPipelineDescriptorTypes : RenderPipelineDescriptor] = [:]
    
    override func fillLibrary() {
        library.updateValue(Basic_RenderPipelineDescriptor(), forKey: .Basic)
        library.updateValue(Skybox_RenderPipelineDescriptor(), forKey: .Skybox)
        library.updateValue(MDLMesh_RenderPipelineDescriptor(), forKey: .MDLMesh)
        library.updateValue(TerrainTextured_RenderPipelineDescriptor(), forKey: .TerrainTextured)
        library.updateValue(Model_RenderPipelineDescriptor(), forKey: .Model)
        library.updateValue(Instanced_RenderPipelineDescriptor(), forKey: .Instanced)
        library.updateValue(TerrainMultiTextured_RenderPipelineDescriptor(), forKey: .TerrainMultiTextured)
        library.updateValue(Bounding_RenderPipelineDescriptor(), forKey: .Bounding)
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
        renderPipelineDescriptor.colorAttachments[0]!.isBlendingEnabled = true
        renderPipelineDescriptor.colorAttachments[0]!.sourceAlphaBlendFactor = .oneMinusSourceAlpha
        renderPipelineDescriptor.colorAttachments[0]!.destinationAlphaBlendFactor = .sourceAlpha
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Basic]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
    }
    
}

class Bounding_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Bounding Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Bounding]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Bounding]
    }
    
}



class Skybox_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Skybox Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
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
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
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
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Terrain]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.TerrainTextured]
    }
}

class Model_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Model Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.colorAttachments[0]!.isBlendingEnabled = false
        renderPipelineDescriptor.colorAttachments[0]!.alphaBlendOperation = .add
        renderPipelineDescriptor.colorAttachments[0]!.rgbBlendOperation = .add
        renderPipelineDescriptor.colorAttachments[0]!.sourceRGBBlendFactor = .sourceAlpha
        renderPipelineDescriptor.colorAttachments[0]!.sourceAlphaBlendFactor = .sourceAlpha
        renderPipelineDescriptor.colorAttachments[0]!.destinationRGBBlendFactor = .one
        renderPipelineDescriptor.colorAttachments[0]!.destinationAlphaBlendFactor = .one
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Model]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Model]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
    }
}

class Instanced_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Instanced Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.colorAttachments[0]!.isBlendingEnabled = true
        renderPipelineDescriptor.colorAttachments[0]!.alphaBlendOperation = .add
        renderPipelineDescriptor.colorAttachments[0]!.rgbBlendOperation = .add
        renderPipelineDescriptor.colorAttachments[0]!.sourceRGBBlendFactor = .sourceAlpha
        renderPipelineDescriptor.colorAttachments[0]!.sourceAlphaBlendFactor = .sourceAlpha
        renderPipelineDescriptor.colorAttachments[0]!.destinationRGBBlendFactor = .one
        renderPipelineDescriptor.colorAttachments[0]!.destinationAlphaBlendFactor = .one
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Instanced]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
    }
    
}

class TerrainMultiTextured_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Terrain Multi Textured Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Terrain]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.TerrainMultiTextured]
    }
}

class Shadow_RenderPipelineDescriptor: RenderPipelineDescriptor {
    var name: String = "Shadow Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    
    init() {
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Terrain]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.TerrainMultiTextured]
    }
}




