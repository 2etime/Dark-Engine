import MetalKit

enum RenderPipelineStateTypes {
    case Basic
    case Skybox
    case MDLMesh
}

class RenderPipelineStateLibrary: Library<RenderPipelineStateTypes, MTLRenderPipelineState> {
    
    private var library: [RenderPipelineStateTypes : RenderPipelineState] = [:]

    override func fillLibrary() {
        library.updateValue(Basic_RenderPipelineState(), forKey: .Basic)
        library.updateValue(Skybox_RenderPipelineState(), forKey: .Skybox)
        library.updateValue(MDLMesh_RenderPipelineState(), forKey: .MDLMesh)
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
