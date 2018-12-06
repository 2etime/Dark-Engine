import MetalKit

enum VertexShaderTypes {
    case Basic
    case Skybox
    case Terrain
    case Model
    case Instanced
    case Shadow
    case Bounding
    case BasicFont
    case BasicGui
}

class VertexShaderLibrary: Library<VertexShaderTypes, MTLFunction> {
    private var library: [VertexShaderTypes : Shader] = [:]

    override func fillLibrary() {
        library.updateValue(Shader(label: "Basic Vertex Shader",
                                   functionName: "basic_vertex_shader"),
                            forKey: .Basic)
        library.updateValue(Shader(label: "Skybox Vertex Shader",
                                   functionName: "skybox_vertex"),
                            forKey: .Skybox)
        library.updateValue(Shader(label: "Terrain Vertex Shader",
                                   functionName: "terrain_vertex_shader"),
                            forKey: .Terrain)
        library.updateValue(Shader(label: "Model Vertex Shader",
                                   functionName: "model_vertex_shader"),
                            forKey: .Model)
        library.updateValue(Shader(label: "Instanced Vertex Shader",
                                   functionName: "instanced_vertex_shader"),
                            forKey: .Instanced)
        library.updateValue(Shader(label: "Shadow Vertex Shader",
                                   functionName: "shadow_vertex_shader"),
                            forKey: .Shadow)
        library.updateValue(Shader(label: "Bounding Vertex Shader",
                                   functionName: "bounding_vertex_shader"),
                            forKey: .Bounding)
        library.updateValue(Shader(label: "Basic Font Vertex Shader",
                                   functionName: "basic_font_vertex"),
                            forKey: .BasicFont)
        library.updateValue(Shader(label: "Basic Gui Vertex Shader",
                                   functionName: "basic_gui_vertex"),
                            forKey: .BasicGui)
    }
    
    override subscript(_ type: VertexShaderTypes) -> MTLFunction {
        return (library[type]?.function)!
    }
}

private class Shader {
    var name: String = ""
    var functionName: String = ""
    var function: MTLFunction!
    
    init(label: String, functionName: String) {
        self.function = DarkEngine.DefaultLibrary.makeFunction(name: functionName)
        self.function.label = label
    }
}

