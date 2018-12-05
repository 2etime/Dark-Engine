import MetalKit

enum RenderPipelineStateTypes {
    case Basic
    case Skybox
    case MDLMesh
    case TerrainTextured
    case Model
    case Instanced
    case TerrainMultiTextured
    case Bounding
    case BasicFont
    case FieldDistanceFont
}

class RenderPipelineStateLibrary: Library<RenderPipelineStateTypes, MTLRenderPipelineState> {
    
    private var library: [RenderPipelineStateTypes : RenderPipelineState] = [:]

    override func fillLibrary() {
        library.updateValue(Basic_RenderPipelineState(), forKey: .Basic)
        library.updateValue(Skybox_RenderPipelineState(), forKey: .Skybox)
        library.updateValue(MDLMesh_RenderPipelineState(), forKey: .MDLMesh)
        library.updateValue(TerrainTextured_RenderPipelineState(), forKey: .TerrainTextured)
        library.updateValue(Model_RenderPipelineState(), forKey: .Model)
        library.updateValue(Instanced_RenderPipelineState(), forKey: .Instanced)
        library.updateValue(TerrainMultiTextured_RenderPipelineState(), forKey: .TerrainMultiTextured)
        library.updateValue(Bounding_RenderPipelineState(), forKey: .Bounding)
        library.updateValue(Basic_Font_RenderPipelineState(), forKey: .BasicFont)
        library.updateValue(Distance_Field_Text_RenderPipelineState(), forKey: .FieldDistanceFont)
    }
    
    override subscript(_ type: RenderPipelineStateTypes) -> MTLRenderPipelineState {
        return (library[type]?.renderPipelineState!)!
    }
    
}

protocol RenderPipelineState {
    var name: String { get }
    var renderPipelineState: MTLRenderPipelineState! { get }
}

class Basic_RenderPipelineState: RenderPipelineState {
    var name: String = "Basic Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.colorAttachments[0]!.isBlendingEnabled = true
        renderPipelineDescriptor.colorAttachments[0]!.sourceAlphaBlendFactor = .oneMinusSourceAlpha
        renderPipelineDescriptor.colorAttachments[0]!.destinationAlphaBlendFactor = .sourceAlpha
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Basic]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
        
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}
class Skybox_RenderPipelineState: RenderPipelineState {
    var name: String = "Skybox Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.MDLMesh]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Skybox]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Skybox]
        
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}
class MDLMesh_RenderPipelineState: RenderPipelineState {
    var name: String = "MDLMesh Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.MDLMesh]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Basic]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Basic]
        
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}
class TerrainTextured_RenderPipelineState: RenderPipelineState {
    var name: String = "Terrain Textured Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Terrain]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.TerrainTextured]
        
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}
class Model_RenderPipelineState: RenderPipelineState {
    var name: String = "Model Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        do {
            let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
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
            
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}

class Instanced_RenderPipelineState: RenderPipelineState {
    var name: String = "Instanced Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
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
        
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}

class TerrainMultiTextured_RenderPipelineState: RenderPipelineState {
    var name: String = "Terrain Multi Textured Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Terrain]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.TerrainMultiTextured]
        
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}

class Bounding_RenderPipelineState: RenderPipelineState {
    var name: String = "Bounding Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgr10a2Unorm
        renderPipelineDescriptor.depthAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.stencilAttachmentPixelFormat = .depth32Float_stencil8
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.Bounding]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.Bounding]
        
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}

class Basic_Font_RenderPipelineState: RenderPipelineState {
    var name: String = "Text Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
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
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.BasicFont]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.BasicFont]
        
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}

class Distance_Field_Text_RenderPipelineState: RenderPipelineState {
    var name: String = "Text Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
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
        renderPipelineDescriptor.vertexFunction = Graphics.VertexShaders[.BasicFont]
        renderPipelineDescriptor.fragmentFunction = Graphics.FragmentShaders[.FieldDistanceFont]
        
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}

