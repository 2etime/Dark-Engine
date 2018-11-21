import MetalKit

enum VertexShaderTypes {
    case Basic
    case Skybox
    case Terrain
    case Model
    case Instanced
    case Shadow
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

