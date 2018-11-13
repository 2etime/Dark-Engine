import MetalKit

enum RenderPipelineStateTypes {
    case Basic
    case Skybox
    case MDLMesh
    case TerrainTextured
    case Model
    case Instanced
    case TerrainMultiTextured
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
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[.Basic])
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}
class Skybox_RenderPipelineState: RenderPipelineState {
    var name: String = "Skybox Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[.Skybox])
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}
class MDLMesh_RenderPipelineState: RenderPipelineState {
    var name: String = "MDLMesh Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[.MDLMesh])
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}
class TerrainTextured_RenderPipelineState: RenderPipelineState {
    var name: String = "Terrain Textured Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[.TerrainTextured])
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
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[.Model])
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}

class Instanced_RenderPipelineState: RenderPipelineState {
    var name: String = "Instanced Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[.Instanced])
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}

class TerrainMultiTextured_RenderPipelineState: RenderPipelineState {
    var name: String = "Terrain Multi Textured Render Pipeline State"
    var renderPipelineState: MTLRenderPipelineState!
    
    init() {
        do {
            renderPipelineState = try DarkEngine.Device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[.TerrainMultiTextured])
        } catch {
            print("ERROR::CREATING::RENDER_PIPELINE_STATE::\(name)::\(error)")
        }
    }
}

